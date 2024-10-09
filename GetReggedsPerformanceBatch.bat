@echo off

:: Version #
Set Version=1.0

:: Enable Delayed Expansion
setlocal enabledelayedexpansion  >nul 2>nul

:: Set Powershell Execution Policy to Unrestricted
powershell "Set-ExecutionPolicy Unrestricted"  >nul 2>nul

:: Enable ANSI Escape Sequences
reg add "HKCU\CONSOLE" /v "VirtualTerminalLevel" /t REG_DWORD /d "1" /f  >nul 2>nul

:: Disable UAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f  >nul 2>nul

:: Getting Admin Permissions
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto GotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:GotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

::════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
:: Main Menu
:Menu
chcp 65001 >nul 2>&1
cls
set c=[94m
set t=[0m
set w=[31m
set y=[0m
set u=[4m
set q=[0m
echo.
echo.
echo.
echo.
echo                       %w%██████%y%%c%╗%y% %w%███████%y%%c%╗%y%%w%████████%y%%c%╗%y%    %w%██████%y%%c%╗%y% %w%███████%y%%c%╗%y% %w%██████%y%%c%╗%y%  %w%██████%y%%c%╗%y% %w%███████%y%%c%╗%y%%w%██████%y%%c%╗%y% 
echo                      %w%██%y%%c%╔════╝%y% %w%██%y%%c%╔════╝%y%%c%╚══%y%%w%██%y%%c%╔══╝%y%    %w%██%y%%c%╔══%y%%w%██%y%%c%╗%y%%w%██%y%%c%╔════╝%y%%w%██%y%%c%╔════╝%y% %w%██%y%%c%╔════╝%y% %w%██%y%%c%╔════╝%y%%w%██%y%%c%╔══%y%%w%██%y%%c%╗%y%  
echo                      %w%██%y%%c%║%y%  %w%███%c%╗%y%%w%█████%y%%c%╗%y%     %w%██%y%%c%║%y%       %w%██████%y%%c%╔╝%y%%w%█████%y%%c%╗%y%  %w%██%y%%c%║%y%  %w%███%c%╗%y%%w%██%y%%c%║%y%  %w%███%c%╗%y%%w%█████%y%%c%╗%y%  %w%██%y%%c%║  %y%%w%██%y%%c%║%y% 
echo                      %w%██%y%%c%║%y%   %w%██%y%%c%║%y%%w%██%y%%c%╔══╝%y%     %w%██%y%%c%║%y%       %w%██%y%%c%╔══%y%%w%██%y%%c%╗%y%%w%██%y%%c%╔══╝%y%  %w%██%y%%c%║%y%   %w%██%y%%c%║%y%%w%██%y%%c%║%y%   %w%██%y%%c%║%y%%w%██%y%%c%╔══╝%y%  %w%██%y%%c%║  %y%%w%██%y%%c%║%y%     
echo                      %c%╚%y%%w%██████%y%%c%╔╝%y%%w%███████%y%%c%╗%y%   %w%██%y%%c%║%y%       %w%██%y%%c%║  %y%%w%██%y%%c%║%y%%w%███████%y%%c%╗%y%%c%╚%y%%w%██████%y%%c%╔╝%y%%c%╚%y%%w%██████%y%%c%╔╝%y%%w%███████%y%%c%╗%y%%w%██████%y%%c%╔╝%y%
echo                       %c%╚═════╝%y% %c%╚══════╝%y%   %c%╚═╝%y%       %c%╚═╝  ╚═╝%y%%c%╚══════╝%y% %c%╚═════╝%y%  %c%╚═════╝%y% %c%╚══════╝%y%%c%╚═════╝%y%          
echo                                                       %c%%u%Version: %Version%%q%%t%
echo.
echo.
echo %w%════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════%y%
echo.
echo.
echo.
echo                           %w%[%y% %c%%u%1%q%%t% %w%]%y% %c%Performance Tweaks%t%                 		   %w%[%y% %c%%u%2%q% %t%%w%]%y% %c%Option2%t%
echo. 
echo.
echo                           %w%[%y% %c%%u%3%q%%t% %w%]%y% %c%Option3%t%						   %w%[%y% %c%%u%4%q% %t%%w%]%y% %c%Power Plan%t%
echo.
echo.
echo                           %w%[%y% %c%%u%5%q%%t% %w%]%y% %c%Temp Tamer%t%                           	           %w%[%y% %c%%u%6%q%%t% %w%]%y% %c%Option6%t%
echo.
echo								%w%[%y% %c%%u%0%q%%t% %w%]%y% %c%Exit%t%
echo.
echo.
echo.
set choice=
set /p choice=
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='0' goto Exit
if '%choice%'=='1' goto Option1
if '%choice%'=='2' goto Option2
if '%choice%'=='3' goto Option3
if '%choice%'=='4' goto PowerPlan
if '%choice%'=='5' goto TempTamer
if '%choice%'=='6' goto Option6

::════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
:Option1

cls
set c=[94m
set t=[0m
set w=[31m
set y=[0m
set u=[4m
set q=[0m
echo.
echo.
echo.
echo.
echo                       %w%██████%y%%c%╗%y% %w%███████%y%%c%╗%y%%w%████████%y%%c%╗%y%    %w%██████%y%%c%╗%y% %w%███████%y%%c%╗%y% %w%██████%y%%c%╗%y%  %w%██████%y%%c%╗%y% %w%███████%y%%c%╗%y%%w%██████%y%%c%╗%y% 
echo                      %w%██%y%%c%╔════╝%y% %w%██%y%%c%╔════╝%y%%c%╚══%y%%w%██%y%%c%╔══╝%y%    %w%██%y%%c%╔══%y%%w%██%y%%c%╗%y%%w%██%y%%c%╔════╝%y%%w%██%y%%c%╔════╝%y% %w%██%y%%c%╔════╝%y% %w%██%y%%c%╔════╝%y%%w%██%y%%c%╔══%y%%w%██%y%%c%╗%y%  
echo                      %w%██%y%%c%║%y%  %w%███%c%╗%y%%w%█████%y%%c%╗%y%     %w%██%y%%c%║%y%       %w%██████%y%%c%╔╝%y%%w%█████%y%%c%╗%y%  %w%██%y%%c%║%y%  %w%███%c%╗%y%%w%██%y%%c%║%y%  %w%███%c%╗%y%%w%█████%y%%c%╗%y%  %w%██%y%%c%║  %y%%w%██%y%%c%║%y% 
echo                      %w%██%y%%c%║%y%   %w%██%y%%c%║%y%%w%██%y%%c%╔══╝%y%     %w%██%y%%c%║%y%       %w%██%y%%c%╔══%y%%w%██%y%%c%╗%y%%w%██%y%%c%╔══╝%y%  %w%██%y%%c%║%y%   %w%██%y%%c%║%y%%w%██%y%%c%║%y%   %w%██%y%%c%║%y%%w%██%y%%c%╔══╝%y%  %w%██%y%%c%║  %y%%w%██%y%%c%║%y%     
echo                      %c%╚%y%%w%██████%y%%c%╔╝%y%%w%███████%y%%c%╗%y%   %w%██%y%%c%║%y%       %w%██%y%%c%║  %y%%w%██%y%%c%║%y%%w%███████%y%%c%╗%y%%c%╚%y%%w%██████%y%%c%╔╝%y%%c%╚%y%%w%██████%y%%c%╔╝%y%%w%███████%y%%c%╗%y%%w%██████%y%%c%╔╝%y%
echo                       %c%╚═════╝%y% %c%╚══════╝%y%   %c%╚═╝%y%       %c%╚═╝  ╚═╝%y%%c%╚══════╝%y% %c%╚═════╝%y%  %c%╚═════╝%y% %c%╚══════╝%y%%c%╚═════╝%y%          
echo                                                       %c%%u%Version: %Version%%q%%t%
echo.
echo.
echo %w%════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════%y%
echo.
echo.
echo.                                          Do you want to create a restor point?
echo.
echo.
echo                                              %w%[%y% %c%%u%1%q%%t% %w%]%y% %c%Yes%t%               %w%[%y% %c%%u%2%q%%t% %w%]%y% %c%No%t%
set choice=
set /p choice=
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto RestorePoint
if '%choice%'=='2' goto WindowsVersion

:RestorePoint
:: Creating restore point
cls
echo Creating restore point
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d "0" /f
powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'GetRegged Performance Batch' -RestorePointType 'MODIFY_SETTINGS'"

cls
echo Restore point created
timeout /t 2 /nobreak > NUL

:WindowsVersion
cls
set c=[94m
set t=[0m
set w=[31m
set y=[0m
set u=[4m
set q=[0m
echo.
echo.
echo.
echo.
echo                       %w%██████%y%%c%╗%y% %w%███████%y%%c%╗%y%%w%████████%y%%c%╗%y%    %w%██████%y%%c%╗%y% %w%███████%y%%c%╗%y% %w%██████%y%%c%╗%y%  %w%██████%y%%c%╗%y% %w%███████%y%%c%╗%y%%w%██████%y%%c%╗%y% 
echo                      %w%██%y%%c%╔════╝%y% %w%██%y%%c%╔════╝%y%%c%╚══%y%%w%██%y%%c%╔══╝%y%    %w%██%y%%c%╔══%y%%w%██%y%%c%╗%y%%w%██%y%%c%╔════╝%y%%w%██%y%%c%╔════╝%y% %w%██%y%%c%╔════╝%y% %w%██%y%%c%╔════╝%y%%w%██%y%%c%╔══%y%%w%██%y%%c%╗%y%  
echo                      %w%██%y%%c%║%y%  %w%███%c%╗%y%%w%█████%y%%c%╗%y%     %w%██%y%%c%║%y%       %w%██████%y%%c%╔╝%y%%w%█████%y%%c%╗%y%  %w%██%y%%c%║%y%  %w%███%c%╗%y%%w%██%y%%c%║%y%  %w%███%c%╗%y%%w%█████%y%%c%╗%y%  %w%██%y%%c%║  %y%%w%██%y%%c%║%y% 
echo                      %w%██%y%%c%║%y%   %w%██%y%%c%║%y%%w%██%y%%c%╔══╝%y%     %w%██%y%%c%║%y%       %w%██%y%%c%╔══%y%%w%██%y%%c%╗%y%%w%██%y%%c%╔══╝%y%  %w%██%y%%c%║%y%   %w%██%y%%c%║%y%%w%██%y%%c%║%y%   %w%██%y%%c%║%y%%w%██%y%%c%╔══╝%y%  %w%██%y%%c%║  %y%%w%██%y%%c%║%y%     
echo                      %c%╚%y%%w%██████%y%%c%╔╝%y%%w%███████%y%%c%╗%y%   %w%██%y%%c%║%y%       %w%██%y%%c%║  %y%%w%██%y%%c%║%y%%w%███████%y%%c%╗%y%%c%╚%y%%w%██████%y%%c%╔╝%y%%c%╚%y%%w%██████%y%%c%╔╝%y%%w%███████%y%%c%╗%y%%w%██████%y%%c%╔╝%y%
echo                       %c%╚═════╝%y% %c%╚══════╝%y%   %c%╚═╝%y%       %c%╚═╝  ╚═╝%y%%c%╚══════╝%y% %c%╚═════╝%y%  %c%╚═════╝%y% %c%╚══════╝%y%%c%╚═════╝%y%          
echo                                                       %c%%u%Version: %Version%%q%%t%
echo.
echo.
echo %w%════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════%y%
echo.
echo.
echo.
echo.
echo.
echo                                              %w%[%y% %c%%u%1%q%%t% %w%]%y% %c%Windows 10%t%               %w%[%y% %c%%u%2%q%%t% %w%]%y% %c%Windows 11%t%
set choice=
set /p choice=
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto Windows10
if '%choice%'=='2' goto Windows11

:Windows10
cls

echo Completed
timeout /t 2 /nobreak > NUL
goto menuexit

:Windows11
cls

echo NOT SUPPORTED YET
timeout /t 2 /nobreak > NUL
goto menuexit

::════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
:Option2
cls

echo Completed
timeout /t 2 /nobreak > NUL
goto menuexit

::════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
:Option3
cls

echo Completed
timeout /t 2 /nobreak > NUL
goto menuexit

::════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
:Option4
cls

echo Completed
timeout /t 2 /nobreak > NUL
goto menuexit

::════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
:PowerPlan
cls
echo Importing Bitsum Highest Performance Power Plan
timeout /t 1 /nobreak > NUL

:: Import GetRegged Power Plan
curl -g -k -L -# -o "%temp%\Bitsum-Highest-Performance.pow" "https://github.com/GetRegged/GetRegged-Performance-Batch/raw/main/bin/Bitsum-Highest-Performance.pow" >nul 2>nul
powercfg -import "%temp%\Bitsum-Highest-Performance.pow" 11111111-1111-1111-1111-111111111111 >nul 2>nul
powercfg -setactive 11111111-1111-1111-1111-111111111111 >nul 2>nul

cls
echo Completed
timeout /t 2 /nobreak > NUL

cls
set c=[94m
set t=[0m
set w=[31m
set y=[0m
set u=[4m
set q=[0m
echo.
echo.
echo.
echo.
echo                       %w%██████%y%%c%╗%y% %w%███████%y%%c%╗%y%%w%████████%y%%c%╗%y%    %w%██████%y%%c%╗%y% %w%███████%y%%c%╗%y% %w%██████%y%%c%╗%y%  %w%██████%y%%c%╗%y% %w%███████%y%%c%╗%y%%w%██████%y%%c%╗%y% 
echo                      %w%██%y%%c%╔════╝%y% %w%██%y%%c%╔════╝%y%%c%╚══%y%%w%██%y%%c%╔══╝%y%    %w%██%y%%c%╔══%y%%w%██%y%%c%╗%y%%w%██%y%%c%╔════╝%y%%w%██%y%%c%╔════╝%y% %w%██%y%%c%╔════╝%y% %w%██%y%%c%╔════╝%y%%w%██%y%%c%╔══%y%%w%██%y%%c%╗%y%  
echo                      %w%██%y%%c%║%y%  %w%███%c%╗%y%%w%█████%y%%c%╗%y%     %w%██%y%%c%║%y%       %w%██████%y%%c%╔╝%y%%w%█████%y%%c%╗%y%  %w%██%y%%c%║%y%  %w%███%c%╗%y%%w%██%y%%c%║%y%  %w%███%c%╗%y%%w%█████%y%%c%╗%y%  %w%██%y%%c%║  %y%%w%██%y%%c%║%y% 
echo                      %w%██%y%%c%║%y%   %w%██%y%%c%║%y%%w%██%y%%c%╔══╝%y%     %w%██%y%%c%║%y%       %w%██%y%%c%╔══%y%%w%██%y%%c%╗%y%%w%██%y%%c%╔══╝%y%  %w%██%y%%c%║%y%   %w%██%y%%c%║%y%%w%██%y%%c%║%y%   %w%██%y%%c%║%y%%w%██%y%%c%╔══╝%y%  %w%██%y%%c%║  %y%%w%██%y%%c%║%y%     
echo                      %c%╚%y%%w%██████%y%%c%╔╝%y%%w%███████%y%%c%╗%y%   %w%██%y%%c%║%y%       %w%██%y%%c%║  %y%%w%██%y%%c%║%y%%w%███████%y%%c%╗%y%%c%╚%y%%w%██████%y%%c%╔╝%y%%c%╚%y%%w%██████%y%%c%╔╝%y%%w%███████%y%%c%╗%y%%w%██████%y%%c%╔╝%y%
echo                       %c%╚═════╝%y% %c%╚══════╝%y%   %c%╚═╝%y%       %c%╚═╝  ╚═╝%y%%c%╚══════╝%y% %c%╚═════╝%y%  %c%╚═════╝%y% %c%╚══════╝%y%%c%╚═════╝%y%          
echo                                                       %c%%u%Version: %Version%%q%%t%
echo.
echo.
echo %w%════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════%y%
echo.
echo.
echo.                                          Do you want to delete all other plans?
echo.
echo.
echo                                              %w%[%y% %c%%u%1%q%%t% %w%]%y% %c%Yes%t%               %w%[%y% %c%%u%2%q%%t% %w%]%y% %c%No%t%
set choice=
set /p choice=
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto DeletePlans
if '%choice%'=='2' goto menuexit

:DeletePlans
cls
echo Deleting other power plans
timeout /t 2 /nobreak > NUL

:: Delete Balanced Power Plan
powercfg -delete 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>nul

:: Delete Power Saver Power Plan
powercfg -delete a1841308-3541-4fab-bc81-f71556f20b4a >nul 2>nul

:: Delete High Performance Power Plan
powercfg -delete 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>nul

:: Delete Ultimate Performance Power Plan
powercfg -delete e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>nul

:: Delete AMD Ryzen Balanced Power Plan
powercfg -delete 9897998c-92de-4669-853f-b7cd3ecb2790 >nul 2>nul


cls
echo Completed 
timeout /t 2 /nobreak > NUL

goto menuexit

::════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
:TempTamer
cls
echo Cleaning IP cache

:: Zurücksetzen und Löschen des IP-Caches
ipconfig /flushdns >nul 2>nul
ipconfig /release >nul 2>nul
ipconfig /renew >nul 2>nul
netsh int ip reset >nul 2>nul
netsh int ipv4 reset >nul 2>nul
netsh int ipv6 reset >nul 2>nul
netsh int tcp reset >nul 2>nul
netsh winsock reset >nul 2>nul
netsh branchcache reset >nul 2>nul
netsh http flush logbuffer >nul 2>nul

echo Cleaning temporary files
timeout /t 2 /nobreak > NUL

:: Löschen von Cache und temporären Dateien
del /s /f /q "%AppData%\Discord\Cache" >nul 2>nul
del /s /f /q "%AppData%\Discord\Code Cache" >nul 2>nul
del /s /f /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache" >nul 2>nul
del /s /f /q "%LocalAppData%\Microsoft\Windows\Explorer\*.db" >nul 2>nul
del /s /f /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>nul
del /s /f /q "%LocalAppData%\Microsoft\Windows\INetCache" >nul 2>nul
del /s /f /q "%LocalAppData%\Microsoft\Windows\INetCookies" >nul 2>nul
del /s /f /q "%LocalAppData%\Microsoft\Windows\WebCache" >nul 2>nul
del /s /f /q "%ProgramData%\Microsoft\Windows\Installer" >nul 2>nul
del /s /f /q "%ProgramData%\USOPrivate\UpdateStore" >nul 2>nul
del /s /f /q "%ProgramData%\USOShared\Logs" >nul 2>nul
del /s /f /q "%systemdrive%\$Recycle.Bin" >nul 2>nul
del /s /f /q "%temp%" >nul 2>nul
del /s /f /q "%windir%\Installer\$PatchCache$" >nul 2>nul
del /s /f /q "%windir%\Logs" >nul 2>nul
del /s /f /q "%windir%\Prefetch" >nul 2>nul
del /s /f /q "%windir%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization" >nul 2>nul
del /s /f /q "%windir%\SoftwareDistribution\Download" >nul 2>nul
del /s /f /q "%windir%\System32\SleepStudy" >nul 2>nul
del /s /f /q "%windir%\temp" >nul 2>nul

echo Cleaning temporary folders
timeout /t 2 /nobreak > NUL

:: Löschen von temporären Systemordnern
rd /s /q "%SystemDrive%\$GetCurrent" >nul 2>nul
rd /s /q "%SystemDrive%\$SysReset" >nul 2>nul
rd /s /q "%SystemDrive%\$WinREAgent" >nul 2>nul
rd /s /q "%SystemDrive%\$Windows.~BT" >nul 2>nul
rd /s /q "%SystemDrive%\$Windows.~WS" >nul 2>nul
rd /s /q "%SystemDrive%\Intel" >nul 2>nul
rd /s /q "%SystemDrive%\AMD" >nul 2>nul
rd /s /q "%SystemDrive%\OneDriveTemp" >nul 2>nul
rd /s /q "%SystemDrive%\System Volume Information" >nul 2>nul

FOR /F "tokens=1,2*" %%V IN ('bcdedit') DO SET adminTest=%%V
IF (%adminTest%)==(Access) goto noAdmin
for /F "tokens=*" %%G in ('wevtutil.exe el') DO (call :do_clear "%%G")

:do_clear
wevtutil.exe cl %1
goto :end

:noAdmin
goto :end

:end

cls
echo Completed
timeout /t 2 /nobreak > NUL

goto menuexit

::════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
:Option6
cls

echo Completed
timeout /t 2 /nobreak > NUL
goto menuexit

::════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
:menuexit
cls
set c=[94m
set t=[0m
set w=[31m
set y=[0m
set u=[4m
set q=[0m
echo.
echo.
echo.
echo.
echo                       %w%██████%y%%c%╗%y% %w%███████%y%%c%╗%y%%w%████████%y%%c%╗%y%    %w%██████%y%%c%╗%y% %w%███████%y%%c%╗%y% %w%██████%y%%c%╗%y%  %w%██████%y%%c%╗%y% %w%███████%y%%c%╗%y%%w%██████%y%%c%╗%y% 
echo                      %w%██%y%%c%╔════╝%y% %w%██%y%%c%╔════╝%y%%c%╚══%y%%w%██%y%%c%╔══╝%y%    %w%██%y%%c%╔══%y%%w%██%y%%c%╗%y%%w%██%y%%c%╔════╝%y%%w%██%y%%c%╔════╝%y% %w%██%y%%c%╔════╝%y% %w%██%y%%c%╔════╝%y%%w%██%y%%c%╔══%y%%w%██%y%%c%╗%y%  
echo                      %w%██%y%%c%║%y%  %w%███%c%╗%y%%w%█████%y%%c%╗%y%     %w%██%y%%c%║%y%       %w%██████%y%%c%╔╝%y%%w%█████%y%%c%╗%y%  %w%██%y%%c%║%y%  %w%███%c%╗%y%%w%██%y%%c%║%y%  %w%███%c%╗%y%%w%█████%y%%c%╗%y%  %w%██%y%%c%║  %y%%w%██%y%%c%║%y% 
echo                      %w%██%y%%c%║%y%   %w%██%y%%c%║%y%%w%██%y%%c%╔══╝%y%     %w%██%y%%c%║%y%       %w%██%y%%c%╔══%y%%w%██%y%%c%╗%y%%w%██%y%%c%╔══╝%y%  %w%██%y%%c%║%y%   %w%██%y%%c%║%y%%w%██%y%%c%║%y%   %w%██%y%%c%║%y%%w%██%y%%c%╔══╝%y%  %w%██%y%%c%║  %y%%w%██%y%%c%║%y%     
echo                      %c%╚%y%%w%██████%y%%c%╔╝%y%%w%███████%y%%c%╗%y%   %w%██%y%%c%║%y%       %w%██%y%%c%║  %y%%w%██%y%%c%║%y%%w%███████%y%%c%╗%y%%c%╚%y%%w%██████%y%%c%╔╝%y%%c%╚%y%%w%██████%y%%c%╔╝%y%%w%███████%y%%c%╗%y%%w%██████%y%%c%╔╝%y%
echo                       %c%╚═════╝%y% %c%╚══════╝%y%   %c%╚═╝%y%       %c%╚═╝  ╚═╝%y%%c%╚══════╝%y% %c%╚═════╝%y%  %c%╚═════╝%y% %c%╚══════╝%y%%c%╚═════╝%y%          
echo                                                       %c%%u%Version: %Version%%q%%t%
echo.
echo.
echo %w%════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════%y%
echo.
echo.
echo.
echo.
echo.
echo                                              %w%[%y% %c%%u%1%q%%t% %w%]%y% %c%Menu%t%               %w%[%y% %c%%u%2%q%%t% %w%]%y% %c%Exit%t%
set choice=
set /p choice=
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto Menu
if '%choice%'=='2' goto Exit

:Exit
cls 
exit
