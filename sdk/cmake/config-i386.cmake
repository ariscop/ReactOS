
set(SARCH "pc" CACHE STRING
"Sub-architecture to build for. Specify one of:
 pc xbox")

set(OARCH "pentium" CACHE STRING
"Generate instructions for this CPU type. Specify one of:
 pentium, pentiumpro")

set(TUNE "i686" CACHE STRING
"Which CPU ReactOS should be optimized for.")

if(MSVC AND (NOT USE_CLANG_CL))
    set(KDBG FALSE CACHE BOOL
"Whether to compile in the integrated kernel debugger.")
    if(CMAKE_BUILD_TYPE STREQUAL "Release")
        set(_WINKD_ FALSE CACHE BOOL "Whether to compile with the KD protocol.")
    else()
        set(_WINKD_ TRUE CACHE BOOL "Whether to compile with the KD protocol.")
    endif()

else()
    if(CMAKE_BUILD_TYPE STREQUAL "Release")
        set(KDBG FALSE CACHE BOOL "Whether to compile in the integrated kernel debugger.")
    else()
        set(KDBG TRUE CACHE BOOL "Whether to compile in the integrated kernel debugger.")
    endif()
    set(_WINKD_ FALSE CACHE BOOL "Whether to compile with the KD protocol.")
endif()

if(NOT MSVC)
set(STACK_PROTECTOR FALSE CACHE BOOL
"Whether to enbable the GCC stack checker while compiling")
endif()

set(USE_DUMMY_PSEH FALSE CACHE BOOL
"Whether to disable PSEH support.")
