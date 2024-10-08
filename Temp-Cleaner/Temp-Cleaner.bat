@echo off
MODE 16,2
echo TAMING TEMPFILES

REM Zurücksetzen und Löschen des IP-Caches
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

REM Löschen von Cache und temporären Dateien
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

REM Löschen von temporären Systemordnern
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
echo DONE!
timeout /t 2 /nobreak >nul
cls
echo CLOSING IN 3
timeout /t 1 /nobreak >nul
cls
echo CLOSING IN 2
timeout /t 1 /nobreak >nul
cls
echo CLOSING IN 1
timeout /t 1 /nobreak >nul
cls
echo EXIT
timeout /t 1 /nobreak >nul
cls
exit
