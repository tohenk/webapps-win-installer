@echo off

:: Start and Stop Services 1.0
:: Copyright (c) 2021 Toha <tohenk@yahoo.com>
::
:: Last Modified: July 28, 2021

title Start and Stop Services
echo Start and Stop Services 1.0
echo (c) 2021 Toha ^<tohenk@yahoo.com^>
echo --------------------------------
echo.

setlocal

:: Change to current directory,
:: vista run as administrator always start from SYSDIR
%~d0
cd %~dp0
set CD=%~dp0

:: Must be run as admin, https://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights#11995662
net session >nul 2>&1
if not %errorLevel%==0 goto :err_need_admin

set SVCDATA=%CD%services.dat
set SVCLST="%CD%Temp\~services.info"
set SVCTMP="%CD%Temp\~service.tmp"

call :list_started %SVCLST%
for /f "eol=; tokens=1,2 delims==" %%i in (%SVCDATA%) do (
  call :check_service %SVCLST% "%%j" %%i %SVCTMP%
)

goto :end

:list_started
  net start > %1
  goto :eof

:check_service
  find "%~2" %1 > %4
  set STARTED=n
  for /f "skip=2 tokens=1*" %%x in (%~4) do (
    if [%%x]==[%~2] (
      set STARTED=y
    )
  )
  if [%STARTED%]==[y] (
    set MSG=%~2 is started, stop/restart
    set ANSWERS=y/N/r
    set DEFANSWER=n
  ) else (
    set MSG=%~2 is stopped, start
    set ANSWERS=y/N
    set DEFANSWER=n
  )
  set ANSWER=%DEFANSWER%

  :loop
  set /p ANSWER="%MSG% (%ANSWERS%)? "
  if [%ANSWER%]==[] (
    set ANSWER=%DEFANSWER%
    goto :okay
  )
  if /i [%ANSWER%]==[y] goto :okay
  if /i [%ANSWER%]==[n] goto :okay
  if [%STARTED%]==[y] (
    if /i [%ANSWER%]==[r] goto :okay
  )
  goto :loop

  :okay
  if /i [%ANSWER%]==[y] (
    if [%STARTED%]==[y] call :stop %3
    if [%STARTED%]==[n] call :start %3
  )
  if /i [%ANSWER%]==[r] (
    call :stop %3
    call :start %3
  )
  goto :eof

:start
  net start "%1"
  goto :eof

:stop
  net stop "%1"
  goto :eof

:err_need_admin
  echo You need to be an Administrator
  goto :end

:end
endlocal
