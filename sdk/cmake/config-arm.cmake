
set(SARCH "omap3-zoom2" CACHE STRING
"Sub-architecture (board) to build for. Specify one of:
 kurobox versatile omap3-zoom2 omap3-beagle")

set(OARCH "armv7-a" CACHE STRING
"Generate instructions for this CPU type. Specify one of:
 armv5te armv7-a")

set(KDBG FALSE CACHE BOOL
"Whether to compile in the integrated kernel debugger.")

set(_WINKD_ TRUE CACHE BOOL
"Whether to compile with the KD protocol.")

