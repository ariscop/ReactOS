
set(OPTIMIZE "4" CACHE STRING
"What level of optimization to use.
 0 = Off
 1 = Optimize for size (-Os) with some additional options
 2 = Optimize for size (-Os)
 3 = Optimize debugging experience (-Og)
 4 = Optimize (-O1)
 5 = Optimize even more (-O2)
 6 = Optimize yet more (-O3)
 7 = Disregard strict standards compliance (-Ofast)")

set(LTCG FALSE CACHE BOOL
"Whether to build with link-time code generation")

set(GDB FALSE CACHE BOOL
"Whether to compile for debugging with GDB.
If you don't use GDB, don't enable this.")

if(CMAKE_BUILD_TYPE STREQUAL "Release")
    set(DBG FALSE CACHE BOOL
"Whether to compile for debugging.")
else()
    set(DBG TRUE CACHE BOOL
"Whether to compile for debugging.")
endif()

set(_ELF_ FALSE CACHE BOOL
"Whether to compile support for ELF files.
Do not enable unless you know what you're doing.")

set(BUILD_MP TRUE CACHE BOOL
"Whether to build the multiprocessor versions of NTOSKRNL and HAL.")

set(GENERATE_DEPENDENCY_GRAPH FALSE CACHE BOOL
"Whether to create a GraphML dependency graph of DLLs.")

if(MSVC)
set(_PREFAST_ FALSE CACHE BOOL
"Whether to enable PREFAST while compiling.")
set(_VS_ANALYZE_ FALSE CACHE BOOL
"Whether to enable static analysis while compiling.")
endif()
