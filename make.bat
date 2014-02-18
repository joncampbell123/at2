@echo off
set homedir=%~d1\AT2_Compilation_Environment
set path=%homedir%\utils\fpc\bin\i386-win32;%homedir%\utils\mingw\bin;%homedir%\utils\jwasm
cd %homedir%\at2-SDL
if exist adtrack2.res goto :res_ok
windres -i adtrack2.rc -o adtrack2.res
:res_ok
echo.
echo ************************************
echo **                                **
echo **  Compiling MAME OPL3EMU        **
echo **                                **
echo ************************************
echo.
%homedir%\utils\minigw\bin\gcc -c ymf262.c -o ymf262.o -shared -Wall -O1 -std=c99 -fms-extensions -DINLINE="static"
echo.
echo ************************************
echo **                                **
echo **  Compiling APLIB               **
echo **                                **
echo ************************************
echo.
jwasm.exe -coff -Foaplib.o aplib.asm
:aplib_ok
echo.
echo ************************************
echo **                                **
echo **  Compiling ADTRACK2            **
echo **                                **
echo ************************************
echo.
fpc.exe -O1 -OpPENTIUM2 -Ccpascal -Mtp -Rintel -Twin32 -WC -Fusdl adtrack2.pas -oadtrack2.exe
