@echo off
setlocal EnableDelayedExpansion

SET UNIX_PREFIX=%CYGWIN_PREFIX:~9%
echo UNIX_PREFIX is %UNIX_PREFIX%

SET PKG_CONFIG_PATH=%UNIX_PREFIX%/lib/pkgconfig
SET GLIBMM_CFLAGS=-L%UNIX_PREFIX%/Library/usr/bin -lmsys-glib-2.0-0 -lmsys-gobject-2.0-0 -lmsys-gmodule-2.0-0
SET GLIBMM_LIBS=-L%UNIX_PREFIX%/Library/usr/bin -lmsys-glib-2.0-0 -lmsys-gobject-2.0-0 -lmsys-gmodule-2.0-0
SET GIOMM_CFLAGS=-L%UNIX_PREFIX%/Library/usr/bin -lmsys-gio-2.0-0
SET GIOMM_LIBS=-L%UNIX_PREFIX%/Library/usr/bin -lmsys-gio-2.0-0
REM echo GLIBMM_LIBS are "%GLIBMM_LIBS%"
SET LDFLAGS=-L%UNIX_PREFIX%/Library/usr/bin
SET LIBS=-lmsys-glib-2.0-0 -lmsys-gobject-2.0-0 -lmsys-gmodule-2.0-0 -lmsys-gio-2.0-0
SET PATH=%UNIX_PREFIX%/Library/usr/bin;%PATH%

bash configure --prefix %UNIX_PREFIX% --build=i386-pc-mingw32 --disable-static --disable-documentation ^
     --libdir %UNIX_PREFIX%/Library/usr/bin --disable-dependency-tracking 
if errorlevel 1 exit 1

make
if errorlevel 1 exit 1

make check
if errorlevel 1 exit 1

make install
if errorlevel 1 exit 1
