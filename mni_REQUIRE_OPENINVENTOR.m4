# Determine the OpenInventor library installed.
#

AC_DEFUN([mni_REQUIRE_GL],
[
    mni_REQUIRE_LIB(GL,[#include <GL/gl.h>],[glEnd();])
])


AC_DEFUN([mni_REQUIRE_OPENINVENTOR],
[
    AC_REQUIRE([mni_REQUIRE_GL])

    AC_LANG_PUSH(C++)
    mni_LIBS_save=$LIBS
    LIBS="-lCoin $LIBS"

    AC_MSG_CHECKING([for Open Inventor (Coin)])
    AC_TRY_LINK([#include <Inventor/SoDB.h>],
                [SoDB::init();],
	    	[result=yes],
	    	[result=no])
    AC_MSG_RESULT($result)

    if test "$result" = no; then
    	LIBS="-lInventor $mni_LIBS_save"
    	AC_MSG_CHECKING([for Open Inventor (SGI)])
    	AC_TRY_LINK([#include <Inventor/SoDB.h>],
        	    [SoDB::init();],
	   	    [result=yes],
		    [result=no])
    	AC_MSG_RESULT($result)
    fi
    AC_LANG_POP

    if test "$result" = no; then
    	AC_MSG_ERROR([No Open Inventor library detected.])
    fi
])


AC_DEFUN([mni_REQUIRE_QT],
[
    AC_LANG_PUSH(C++)
    mni_REQUIRE_LIB(qt,[#include <qapplication.h>],[QString str;])
    AC_LANG_POP
])
    


dnl This used to have -lXi in it.  Perhaps should AC_REQUIRE the AC_PATH_XTRA
dnl macro and do something intelligent with it.
AC_DEFUN([mni_REQUIRE_SOQT],
[
    AC_REQUIRE([mni_REQUIRE_OPENINVENTOR])
    AC_REQUIRE([mni_REQUIRE_QT])

    AC_LANG_PUSH(C++)
    mni_REQUIRE_LIB(SoQt,[#include <Inventor/Qt/SoQt.h>],[SoQt::mainLoop();])
    AC_LANG_POP
])

