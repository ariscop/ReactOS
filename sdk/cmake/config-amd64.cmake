
set(SARCH "" CACHE STRING
"Sub-architecture to build for.")

set(OARCH "athlon64" CACHE STRING
"Generate instructions for this CPU type. Specify one of:
 k8 opteron athlon64 athlon-fx")

set(KDBG FALSE CACHE BOOL
"Whether to compile in the integrated kernel debugger.")

set(_WINKD_ TRUE CACHE BOOL
"Whether to compile with the KD protocol.")
