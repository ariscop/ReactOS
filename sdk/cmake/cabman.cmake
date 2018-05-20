

function(add_cabinet _target _dff)
    cmake_parse_arguments(_CAB "EXCLUDE_FROM_ALL" "" "" ${ARGN})

    if(NOT _CAB_EXCLUDE_FROM_ALL)
        set(_all "ALL")
    else()
        set(_all)
    endif()

    add_custom_target(${_target}_cabman ${_all}
        SOURCES ${_dff}
        DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${_target}.cab
        DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${_target}.inf)

    set(_dyn_dff_file ${CMAKE_CURRENT_BINARY_DIR}/${_target}.dff.dyn)

    set_property(TARGET ${_target}_cabman PROPERTY _dyn_dff_file ${_dyn_dff_file})

    # hack: make dff file changes re-run cmake by configuring it
    #configure_file(${_dff} ${CMAKE_CURRENT_BINARY_DIR}/.${_target}.dummy)

    file(GENERATE
         OUTPUT ${_dyn_dff_file}
         INPUT  ${_dyn_dff_file}.cmake)

    file(WRITE ${_dyn_dff_file}.cmake "")

    add_custom_command(
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${_target}.dff
        COMMAND ${CMAKE_COMMAND} -D SRC1=${_dff}
                                 -D SRC2=${_dyn_dff_file}
                                 -D DST=${CMAKE_CURRENT_BINARY_DIR}/${_target}.dff
                                 -P ${REACTOS_SOURCE_DIR}/sdk/tools/concat.cmake
        DEPENDS ${_dff}
        DEPENDS ${_dyn_dff_file})

    add_custom_command(
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${_target}.cab ${CMAKE_CURRENT_BINARY_DIR}/${_target}.inf
        COMMAND native-cabman -C ${CMAKE_CURRENT_BINARY_DIR}/${_target}.dff -L ${CMAKE_CURRENT_BINARY_DIR} -P ${REACTOS_SOURCE_DIR}
        DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${_target}.dff native-cabman
        DEPENDS "$<TARGET_PROPERTY:${_target}_cabman,_cab_file_depends>")

    _cabman_parse_dff(${_target}_cabman ${_dff})
endfunction()

function(add_cab_file _target)
    cmake_parse_arguments(_CAB "OPTIONAL" "DESTINATION" "FILE;TARGET" ${ARGN})

    if(NOT (_CAB_TARGET OR _CAB_FILE))
        message(FATAL_ERROR "You must provide a target or a file to install!")
    endif()

    if(NOT _CAB_DESTINATION)
        message(FATAL_ERROR "You must provide a destination")
    endif()

    get_property(_dyn_dff_file TARGET ${_target}_cabman PROPERTY _dyn_dff_file)

    _cabman_path_to_num(${_target} "${_CAB_DESTINATION}" _num)
    if(${_num} EQUAL -1)
        message(FATAL_ERROR "Destination ${_CAB_DESTINATION} not defined in directive file")
    endif()

    if(_CAB_OPTIONAL)
        set(_optional " optional")
    else()
        set(_optional "")
    endif()

    foreach(_cab_target ${_CAB_TARGET})
        file(APPEND ${_dyn_dff_file}.cmake "\"$<TARGET_FILE:${_cab_target}>\" ${_num}${_optional}\n")
        set_property(TARGET ${_target}_cabman APPEND PROPERTY _cab_file_depends ${_cab_target})
    endforeach()

    foreach(_file ${_CAB_FILE})
        file(APPEND ${_dyn_dff_file}.cmake "\"${_file}\" ${_num}${_optional}\n")
        if(NOT _CAB_OPTIONAL)
            set_property(TARGET ${_target}_cabman APPEND PROPERTY _cab_file_depends ${_file})
        endif()
    endforeach()
endfunction()

# Maps paths to their inf number, or return -1 if none exist
function(_cabman_path_to_num _target _path _out)
    get_property(_inf_directories TARGET ${_target}_cabman PROPERTY _inf_directories)
    get_property(_inf_directories_num TARGET ${_target}_cabman PROPERTY _inf_directories_num)

    list(FIND _inf_directories "${_path}" _num)
    if(${_num} EQUAL -1)
        set(${_out} -1 PARENT_SCOPE)
    else()
        list(GET _inf_directories_num ${_num} _num)
        set(${_out} ${_num} PARENT_SCOPE)
    endif()
endfunction()

function(_cabman_parse_dff _target _dff)
    set(section _none)

    file(STRINGS ${_dff} lines ENCODING UTF-8)
    foreach(line ${lines})
        # Strip comments
        list(GET line 0 line)

        if("${line}" MATCHES "^\\.Set ([a-zA-Z]+)=\"?([^\"]+)\"?")
            # Capture cabman variables
            set(var_${CMAKE_MATCH_1} "${CMAKE_MATCH_2}")
        elseif("${line}" MATCHES "^\\[([a-zA-Z]+)\\]")
            set(section ${CMAKE_MATCH_1})
        elseif(section STREQUAL Directories
               AND "${line}" MATCHES "^([0-9]+) += +\"?([^\"]+)\"?")
            # Capture directory->number mappings
            string(REPLACE "\\" "/" _dir "${CMAKE_MATCH_2}")
            set_property(TARGET ${_target} APPEND PROPERTY _inf_directories ${_dir})
            set_property(TARGET ${_target} APPEND PROPERTY _inf_directories_num ${CMAKE_MATCH_1})
        endif()
    endforeach()
endfunction()
