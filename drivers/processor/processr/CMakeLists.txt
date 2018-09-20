
list(APPEND SOURCE
    processr.c
    misc.c
    pnp.c
    processr.h)

add_library(processr SHARED ${SOURCE} processr.rc)
set_module_type(processr kernelmodedriver)
add_importlibs(processr hal ntoskrnl)
add_pch(processr processr.h)
add_cd_file(TARGET processr DESTINATION reactos/system32/drivers FOR all)
