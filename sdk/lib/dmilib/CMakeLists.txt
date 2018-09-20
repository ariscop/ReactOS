
list(APPEND SOURCE
    dmilib.c
    precomp.h)

add_library(dmilib ${SOURCE})
add_pch(dmilib precomp.h)
add_dependencies(dmilib psdk)
