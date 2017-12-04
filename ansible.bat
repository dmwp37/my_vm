@echo off

REM If you used the stand Cygwin installer this will be C:\cygwin
set CYGWIN=C:\cygwin

REM You can switch this to work with bash with %CYGWIN%\bin\bash.exe
set SH=%CYGWIN%\bin\zsh.exe

"%SH%" -c "/bin/ansible %*"
