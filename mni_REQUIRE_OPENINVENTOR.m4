# Determine the OpenInventor library installed.
#

AC_DEFUN([mni_REQUIRE_OPENINVENTOR],
[

   # add the GL libs if able
    mni_LIBS_save=$LIBS
    LIBS="-lGL $LIBS"
    AC_MSG_CHECKING([for GL])
    AC_TRY_LINK([#include <GL/gl.h>],
		[glEnd();],
		[result=yes],
		[result=no])
    AC_MSG_RESULT($result)
    if test "$result" = no; then
	LIBS=$mni_LIBS_save
    fi

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

    if test "$result" = no; then
    	AC_MSG_ERROR([No Open Inventor library detected.])
    fi
])

AC_DEFUN([mni_REQUIRE_SOQT],
[
    AC_REQUIRE([mni_REQUIRE_OPENINVENTOR])
    LIBS="-lqt $LIBS"
    AC_MSG_CHECKING([for QT library])
    AC_TRY_LINK([#include <qapplication.h>],
		[QString str;],
		[result=yes],
		[result=no])
    AC_MSG_RESULT($result)
    if test "$result" = no; then
	AC_MSG_ERROR([No QT library detected.])
    fi

    #the Xi lib should be moved to its own check
    LIBS="-lSoQt -lXi $LIBS"
    AC_MSG_CHECKING([for SoQt])
    AC_TRY_LINK([#include <Inventor/Qt/SoQt.h>],
		[SoQt::mainLoop();],
		[result=yes],
		[result=no])
    AC_MSG_RESULT($result)
    if test "$result" = no; then
	AC_MSG_ERROR([No SoQt library detected.])
    fi
])

