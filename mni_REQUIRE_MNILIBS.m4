AC_DEFUN([mni_REQUIRE_MINC],
[
    mni_REQUIRE_LIB(m,[#include <math.h>],[double x = sqrt(3.);])
    mni_REQUIRE_LIB(netcdf,[#include <netcdf.h>],[int i = ncopen("",0);])
    mni_REQUIRE_LIB(minc,[#include <minc.h>],[int i = miicv_create();])
])


AC_DEFUN([mni_REQUIRE_VOLUMEIO],
[
    AC_REQUIRE([mni_REQUIRE_MINC])
    mni_REQUIRE_LIB(volume_io,
		    [#include <volume_io.h>],
		    [Volume vol; 
	 	     Real voxel = 0;
                     Real x = convert_voxel_to_value(vol,voxel);])
])


AC_DEFUN([mni_REQUIRE_BICPL],
[
    AC_REQUIRE([mni_REQUIRE_VOLUMEIO])
    mni_REQUIRE_LIB(bicpl,
		    [#include <bicpl.h>],
		    [File_formats format;
                     int n_obj;
                     object_struct** obj_list;
                     Status s = input_graphics_file("",&format,&n_obj,&obj_list)])
])

AC_DEFUN([mni_REQUIRE_EBTKS],
[
    AC_LANG_PUSH(C++)
    mni_REQUIRE_LIB(EBTKS, [#include <EBTKS/Path.h>],[Path path;])
    AC_LANG_POP
])

AC_DEFUN([mni_REQUIRE_OOBICPL],
[
    AC_REQUIRE([mni_REQUIRE_BICPL])

    AC_LANG_PUSH(C++)
    mni_REQUIRE_LIB(oobicpl,[#include <mniVolume.h>],[mniVolume vol;])
    AC_LANG_POP
])


AC_DEFUN([mni_REQUIRE_BICINVENTOR],
[
    AC_REQUIRE([mni_REQUIRE_BICPL])
    AC_REQUIRE([mni_REQUIRE_OOBICPL])
    AC_REQUIRE([mni_REQUIRE_OPENINVENTOR])

    AC_LANG_PUSH(C++)
    mni_REQUIRE_LIB(bicInventor,
                    [#include <bicInventor.h>],
                    [SoSeparator* root = bic_graphics_file_to_iv("foo.iv");])
    AC_LANG_POP
])


