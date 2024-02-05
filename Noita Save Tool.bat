@ECHO off 
Rem Noita Save/Backup script
Rem Created by https://github.com/Killer-Kat, inspired by this reddit post https://www.reddit.com/r/noita/comments/da5pwb/scripts_to_backuprestore_your_saves/
rem FASTMODE toggles auto launch after a restore.
set FASTMODE=false
set SAVE=1
set Counter=1
title Noita Save Script
color 0D

Echo.
Echo Noitia Saving Script, Created by Killer-Kat.

Rem this part gets the user input to select the task.
:selection
Echo.
Echo Options: 
Echo 1. Save 
Echo 2. Restore 
Echo 3. Select Save File 
Echo 4. Launch Game 
Echo 5. Exit

CALL :LIST
Echo.

if /I "%FASTMODE%"=="true" ( echo Auto Launch enabled )
set /p input="Select option: "

if "%input%"=="1" ( goto ONE)
if "%input%"=="2" ( goto TWO)
if "%input%"=="3" ( goto SaveSelect)
if "%input%"=="4" ( goto startapp)
if "%input%"=="5" ( exit /b)
if /I "%input%"=="secret" ( goto Secret ) else (
echo Error invalid selection.
SET /a Counter = %Counter% + 1
if "%Counter%"=="6" ( goto Secret )
goto selection )

:LIST

Echo.
CALL :PRINT_SAVE_FILE 1
CALL :PRINT_SAVE_FILE 2
CALL :PRINT_SAVE_FILE 3

exit /b
goto selection

:PRINT_SAVE_FILE
SETLOCAL
set "path_of_folder=%userprofile%\AppData\LocalLow\Nolla_Games_Noita\backup%1"

if %SAVE%==%1 (
set _SLOT=* %1
) else (
set _SLOT=  %1
)

if exist "%path_of_folder%" (  
  for /f "skip=5 tokens=1,2,4 delims= " %%a in (
   'dir /ad /tc "%path_of_folder%\."') do IF "%%c"=="." (
    set "dt=%%a"
	echo %_SLOT% %%a, %%b
  )
) else ( 
  echo %_SLOT% -
)
ENDLOCAL
exit /b

:ONE
rmdir %userprofile%\AppData\LocalLow\Nolla_Games_Noita\backup%SAVE% /s /q
mkdir %userprofile%\AppData\LocalLow\Nolla_Games_Noita\backup%SAVE%
xcopy %userprofile%\AppData\LocalLow\Nolla_Games_Noita\save00\*.* %userprofile%\AppData\LocalLow\Nolla_Games_Noita\backup%SAVE%\*.* /e /y /i
cls
Echo Backup completed.
goto selection

:TWO
mkdir %userprofile%\AppData\LocalLow\Nolla_Games_Noita\save00
xcopy %userprofile%\AppData\LocalLow\Nolla_Games_Noita\backup%SAVE%\*.* %userprofile%\AppData\LocalLow\Nolla_Games_Noita\save00\*.* /e /y /i
cls
echo Backup Restored.
if /I "%FASTMODE%"=="true" ( goto startapp )
goto selection

:startapp
Echo Starting Noita
start steam://rungameid/881100
cls
goto selection
Rem This allows the user to change save files by setting the SAVE variable
:SaveSelect
Echo Please Select Save Slot 1,2,3
set /p SAVE="Set Save File "
if "%SAVE%"=="1" ( goto SSX)
if "%SAVE%"=="2" ( goto SSX)
if "%SAVE%"=="3" ( goto SSX) else (
echo Error invalid selection.
goto SaveSelect )
:SSX
cls
goto selection

:Secret
cls
Rem this for loop changes the color of the text while keeping the background the same for a rainbow effect.
for /l %%x in (1, 1, 15) do (
 ECHO YOU HAVE ANGERED THE GODS
 color 0C
 timeout /t 1 /nobreak >nul
 color 0E
 timeout /t 1 /nobreak >nul
 color 0a
 timeout /t 1 /nobreak >nul
 color 0b
 timeout /t 1 /nobreak >nul
 color 09
 timeout /t 1 /nobreak >nul
 color 0d
 timeout /t 1 /nobreak >nul
)
cls 
goto selection
