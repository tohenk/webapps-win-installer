@echo off

:: Web Application Switcher version 1.0
:: Copyright (c) 2021 Toha <tohenk@yahoo.com>
::
:: Last Modified: July 28, 2021

title Web Application Switcher
echo Web Application Switcher 1.0
echo (c) 2021 Toha ^<tohenk@yahoo.com^>
echo --------------------------------
echo.

setlocal

:: change to current directory; vista run as administrator always start from SYSDIR
%~d0
cd %~dp0
set CD=%~dp0

:: Must be run as admin, https://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights#11995662
net session >nul 2>&1
if not %errorLevel%==0 goto :err_need_admin

set SERVICE=Apache2.4

if [%1]==[] goto nocfgpath
set CONFIG_PATH=%1
goto :setcd

:nocfgpath
set CONFIG_PATH=%cd%Conf\vhosts

:setcd
echo Path to configuration:
echo %CONFIG_PATH%
echo.

call :ch_drive "%CONFIG_PATH%"
call :list_app
call :choose_app %DEFAULT_APP%

if not [%DEFAULT_APP%]==[%APP%] (
  echo.
  echo Please wait, applying changes...
  call :update_app %APP%
  call :restart_service %SERVICE%
)

call :ch_drive "%CD%"
goto :end

:ch_drive
  %~d1
  cd %1
  goto :eof

:list_app
  echo Available applications:
  for /r %%i in (*.conf?) do (
    if [%%~xi]==[.conf] (
      echo - %%~ni [*]
      set DEFAULT_APP=%%~ni
    ) else (
      echo - %%~ni
    )
  )
  echo.
  goto :eof

:choose_app
  set APP=%1
  :choose
  set /p app="Choose application [%APP%]: "
  for /r %%i in (*.*) do (
    if [%%~ni]==[%APP%] (
      goto :eof
    )
  )
  goto :choose

:update_app
  for /r %%i in (*.*) do (
    if [%%~ni]==[%1] (
      if [%%~xi]==[.conf-] call :rename_conf enable "%%i"
    ) else (
      if [%%~xi]==[.conf] call :rename_conf disable "%%i"
    )
  )
  goto :eof

:update_conf
  set UPDATE_TYPE=
  set UPDATE_MSG=
  if [%~x1]==[.conf] (
    set UPDATE_TYPE=disable
    set UPDATE_MSG=Disable %~n1
  )
  if [%~x1]==[.conf-] (
    set UPDATE_TYPE=enable
    set UPDATE_MSG=Enable %~n1
  )
  :loop
  set /p ANSWER="%UPDATE_MSG% [y/n]: "
  if [%ANSWER%]==[y] goto :okay
  if [%ANSWER%]==[n] goto :okay
  goto :loop
  :okay
  if [%ANSWER%]==[y] (
    call :rename_conf %UPDATE_TYPE% %1
  )
  goto :eof

:rename_conf
  if [%1]==[disable] set NEW_NAME=%~n2.conf-
  if [%1]==[enable] set NEW_NAME=%~n2.conf
  ren %2 %NEW_NAME%
  goto :eof

:restart_service
  net stop %1
  net start %1
  goto :eof

:err_need_admin
  echo You need to be an Administrator
  goto :end

:end
endlocal