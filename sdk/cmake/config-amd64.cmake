
set(SARCH "" CACHE STRING
"Sub-architecture to build for.")

set(OARCH "athlon64" CACHE STRING
"Generate instructions for this CPU type. Specify one of:
 k8 opteron athlon64 athlon-fx")

set (OPTIMIZE "1" CACHE STRING
"What level of optimization to use.
 0 = off
 1 = Default option, optimize for size (-Os) with some additional options
 2 = Optimize for size (-Os)
 3 = Optimize debugging experience (-Og)
 4 = Optimize (-O1)
 5 = Optimize even more (-O2)
 6 = Optimize yet more (-O3)
 7 = Disregard strict standards compliance (-Ofast)")

set(KDBG FALSE CACHE BOOL
"Whether to compile in the integrated kernel debugger.")

set(_WINKD_ TRUE CACHE BOOL
"Whether to compile with the KD protocol.")
