# Determine the OpenInventor library installed.
#

AC_DEFUN([mni_REQUIRE_OPENINVENTOR],
[
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
