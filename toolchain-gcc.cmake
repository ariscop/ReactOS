
if(NOT ARCH)
    set(ARCH i386)
endif()

# Default to Debug for the build type
if(NOT DEFINED CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug" CACHE STRING
        "Choose the type of build, options are: None(CMAKE_CXX_FLAGS or CMAKE_C_FLAGS used) Debug Release RelWithDebInfo MinSizeRel.")
endif()

# Choose the right MinGW toolchain prefix
if (NOT DEFINED MINGW_TOOLCHAIN_PREFIX)
    if(ARCH STREQUAL "i386")
        set(MINGW_TOOLCHAIN_PREFIX "i686-w64-mingw32-" CACHE STRING "MinGW Toolchain Prefix")
    elseif(ARCH STREQUAL "amd64")
        set(MINGW_TOOLCHAIN_PREFIX "x86_64-w64-mingw32-" CACHE STRING "MinGW Toolchain Prefix")
    elseif(ARCH STREQUAL "arm")
        set(MINGW_TOOLCHAIN_PREFIX "arm-mingw32ce-" CACHE STRING "MinGW Toolchain Prefix")
    endif()
endif()

if(ENABLE_CCACHE)
    set(CCACHE "ccache" CACHE STRING "ccache")
else()
    set(CCACHE "" CACHE STRING "ccache")
endif()

# The name of the target operating system
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR i686)

# Which tools to use
set(CMAKE_C_COMPILER   ${MINGW_TOOLCHAIN_PREFIX}gcc)
set(CMAKE_CXX_COMPILER ${MINGW_TOOLCHAIN_PREFIX}g++)
set(CMAKE_ASM_COMPILER ${MINGW_TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER_ID "GNU")
set(CMAKE_MC_COMPILER  ${MINGW_TOOLCHAIN_PREFIX}windmc)
set(CMAKE_RC_COMPILER  ${MINGW_TOOLCHAIN_PREFIX}windres)
set(CMAKE_DLLTOOL ${MINGW_TOOLCHAIN_PREFIX}dlltool)
#set(CMAKE_AR ${MINGW_TOOLCHAIN_PREFIX}gcc-ar)
set(CMAKE_OBJCOPY ${MINGW_TOOLCHAIN_PREFIX}objcopy)

set(CMAKE_C_CREATE_STATIC_LIBRARY "<CMAKE_AR> crT <TARGET> <LINK_FLAGS> <OBJECTS>")
set(CMAKE_CXX_CREATE_STATIC_LIBRARY ${CMAKE_C_CREATE_STATIC_LIBRARY})
set(CMAKE_ASM_CREATE_STATIC_LIBRARY ${CMAKE_C_CREATE_STATIC_LIBRARY})

# Don't link with anything by default unless we say so
set(CMAKE_C_STANDARD_LIBRARIES "-lgcc" CACHE STRING "Standard C Libraries")

#MARK_AS_ADVANCED(CLEAR CMAKE_CXX_STANDARD_LIBRARIES)
set(CMAKE_CXX_STANDARD_LIBRARIES "-lgcc" CACHE STRING "Standard C++ Libraries")

set(CMAKE_SHARED_LINKER_FLAGS_INIT "-nostdlib -Wl,--enable-auto-image-base,--disable-auto-import")
set(CMAKE_MODULE_LINKER_FLAGS_INIT "-nostdlib -Wl,--enable-auto-image-base,--disable-auto-import")

set(CMAKE_USER_MAKE_RULES_OVERRIDE "${CMAKE_CURRENT_LIST_DIR}/overrides-gcc.cmake")

# Get GCC version
execute_process(COMMAND ${CMAKE_C_COMPILER} -dumpversion OUTPUT_VARIABLE GCC_VERSION)
