@echo off
setlocal enabledelayedexpansion
title NETWORK MASTER CONTROL v14.7.9 Stable

:: CONFIG PERSISTENCE PATHS
set "cfg_folder=%temp%\nmc_suite"
if not exist "%cfg_folder%" mkdir "%cfg_folder%"
set "theme_file=%cfg_folder%\theme.dat"
set "skip_file=%cfg_folder%\skip.dat"
set "git_url=https://github.com/r3v3nan1/Project-Lag-tester"
set "z_h=30" & set "z_w=48"

:: LOAD SYSTEM CONFIGS
if exist "%theme_file%" (set /p theme=<"%theme_file%") else (set "theme=02")
if exist "%skip_file%" (set /p always_skip=<"%skip_file%") else (set "always_skip=OFF")

:: FORCE FULLSCREEN & ULTRA ZOOM
if not "%1"=="max" start /max cmd /c %0 max & exit
powershell -command "& { $p = Get-Process -Id $pid; $h = $p.MainWindowHandle; $s = [Windows.Win32.PInvoke]::GetWindowLong($h, -16); $s = $s -band -xor 0x00C00000; [Windows.Win32.PInvoke]::SetWindowLong($h, -16, $s); [Windows.Win32.PInvoke]::ShowWindow($h, 3); $config = Get-Host; $config.UI.RawUI.FontSize = New-Object System.Management.Automation.Host.Size(%z_h%,%z_w%) }" >nul 2>&1

:: BYPASS ENGINE
if "%always_skip%"=="ON" goto :MENU

:: INTERRUPTIBLE BOOT SEQUENCE
@echo off
cls & color 02 & echo. & echo   [ SYSTEM BOOTING... ]
choice /c ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 /t 1 /d A /n >nul
cls & color 0D & echo. & echo   [ LOADING ENGINE CORES... ]
choice /c ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 /t 1 /d A /n >nul
cls & color 0B & echo. & echo   [ SYNCING PACKET MATRICES... ]
choice /c ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 /t 1 /d A /n >nul
cls & color 0A & echo. & echo   [ VERIFYING PROJECT-LAG-TESTER... ]
choice /c ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 /t 1 /d A /n >nul

:MENU
@echo off
color %theme%
cls
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address"') do set "my_ip=%%a"
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"Default Gateway"') do set "my_gw=%%a"
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interfaces ^| findstr /c:" SSID"') do set "my_ssid=%%a"
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interfaces ^| findstr /c:" Signal"') do set "my_sig=%%a"
set "my_ip=%my_ip: =%" & set "my_gw=%my_gw: =%" & set "my_ssid=%my_ssid: =%" & set "my_sig=%my_sig: =%"

echo.
echo  +-----------------------------------------------------------+
echo  ^|             NETWORK MASTER CONTROL CENTER                 ^|
echo  ^|             [ VERSION : 14.7.9 STABLE PRO ]               ^|
echo  +-----------------------------------------------------------+
echo  ^|  IP      : %my_ip%                                        
echo  ^|  GATEWAY : %my_gw%          SIGNAL    : %my_sig%           
echo  ^|  WIFI    : %my_ssid%                                      
echo  +-----------------------------------------------------------+
echo.
echo      1. START MONITOR      ( Real-Time Live Stream )
echo.
echo      2. LIGHT CONGESTION   ( 5 Streams )
echo.
echo      3. MEDIUM CONGESTION  ( 15 Streams )
echo.
echo      4. HEAVY FLOOD        ( 30 Streams )
echo.
echo      5. CUSTOM ATTACK      ( Manual Entry )
echo.
echo      6. STOP ALL / NUKE    ( Deep Reset )
echo.
echo      7. SYSTEM SETTINGS    ( Engine Matrix )
echo.
echo      8. GITHUB REPOSITORY  ( Project-Lag-tester )
echo.
echo      9. EXIT PROGRAM
echo.
echo  +---[ PROJECT DISCLAIMER / TERMS OF USE ]-------------------+
echo  ^| This is supposed to be used to test network stability and ^|
echo  ^| not for malicious uses. Report bugs to the GitHub repo.   ^|
echo  ^| By using or pasting this code you agree that all actions   ^|
echo  ^| are YOUR OWN FAULT and the creator is not responsible for ^|
echo  ^| legal issues or punishments. USE AT YOUR OWN RISK.       ^|
echo  ^| DO NOT CRASH WORKPLACE OR HOME NETWORKS INTERNET CORES.   ^|
echo  +-----------------------------------------------------------+
echo.
set /p mode="  >> SELECT OPTION: "

if "%mode%"=="1" goto :CHECKER
if "%mode%"=="2" set "win=5" & set "cnt=100" & set "psize=64000" & goto :LAUNCH
if "%mode%"=="3" set "win=15" & set "cnt=500" & set "psize=64000" & goto :LAUNCH
if "%mode%"=="4" set "win=30" & set "cnt=1000" & set "psize=64000" & goto :LAUNCH
if "%mode%"=="5" goto :CUSTOM
if "%mode%"=="6" goto :NUKE
if "%mode%"=="7" goto :SETTINGS
if "%mode%"=="8" start "" "%git_url%" & goto :MENU
if "%mode%"=="9" exit
goto :MENU

:SETTINGS
@echo off
cls
echo.
echo  +-----------------------------------------------------------+
echo  ^|                SYSTEM ENGINE OPTIMIZATION                 ^|
echo  +-----------------------------------------------------------+
echo.
echo     1. GREEN   2. AMBER   3. BLUE   4. WHITE
echo     5. AQUA    6. PURPLE  7. RED    8. GRAY
echo.
echo     9. TOGGLE ALWAYS SKIP [CURRENT: %always_skip%]
echo.
echo     10. RETURN TO MENU
echo.
set /p s_choice="  >> CONFIG SELECTION ID: "
if "%s_choice%"=="1" set "theme=02" & echo 02>"%theme_file%" & goto :MENU
if "%s_choice%"=="2" set "theme=06" & echo 06>"%theme_file%" & goto :MENU
if "%s_choice%"=="3" set "theme=09" & echo 09>"%theme_file%" & goto :MENU
if "%s_choice%"=="4" set "theme=0F" & echo 0F>"%theme_file%" & goto :MENU
if "%s_choice%"=="5" set "theme=0B" & echo 0B>"%theme_file%" & goto :MENU
if "%s_choice%"=="6" set "theme=0D" & echo 0D>"%theme_file%" & goto :MENU
if "%s_choice%"=="7" set "theme=04" & echo 04>"%theme_file%" & goto :MENU
if "%s_choice%"=="8" set "theme=08" & echo 08>"%theme_file%" & goto :MENU

if "%s_choice%"=="9" (
    if "%always_skip%"=="ON" (set "always_skip=OFF") else (set "always_skip=ON")
    echo !always_skip!>"%skip_file%"
    goto :SETTINGS
)
if "%s_choice%"=="10" goto :MENU
goto :SETTINGS

:CUSTOM
@echo off
echo.
set /p win="  [?] Windows: "
set /p cnt="  [?] Count: "
set /p psize="  [?] Packet Size: "
goto :LAUNCH

:LAUNCH
@echo off
for /L %%i in (1,1,%win%) do (
    set /a "perc=(%%i*100)/%win%"
    set "load_bar="
    set /a "blocks=!perc!/5"
    for /L %%b in (1,1,!blocks!) do set "load_bar=!load_bar!="
    
    start /high /min cmd /c "color %theme% && ping %my_gw% -n %cnt% -l %psize% -w 1"
    
    cls
    echo.
    echo  +-----------------------------------------------------------+
    echo    DEPLOYING PACKETS: %%i / %win%
    echo    STATUS TRACKER   : [!load_bar!] !perc!%%
    echo  +-----------------------------------------------------------+
    choice /c ABCDEFGHIJKLMNOPQRSTUVWXYZ /t 1 /d A /n >nul
)
goto :MENU

:CHECKER
@echo off
cls
echo.
echo  +-----------------------------------------------------------+
echo  ^|                 INITIALIZING LIVE FEED                    ^|
echo  +-----------------------------------------------------------+
echo.
set /p t_ip="  >> TARGET IP (Press ENTER for Gateway %my_gw%): "
if "!t_ip!"=="" set "t_ip=%my_gw%"

:C_LOOP
cls
echo  +-----------------------------------------------------------+
echo  ^|  LIVE REFRESH DIAL: %t_ip%         [PRESS M TO EXIT MENU]  ^|
echo  +-----------------------------------------------------------+
echo.
ping -n 1 -w 1000 %t_ip%
echo.
echo  +-----------------------------------------------------------+

choice /c CM /t 1 /d C /n >nul
if errorlevel 2 (
    goto :MENU
)
goto :C_LOOP

:NUKE
@echo off
cls & color 0C
echo.
echo  +-----------------------------------------------------------+
echo  ^|                 PURGING ENGINE RUNTIMES                   ^|
echo  +-----------------------------------------------------------+
echo.
echo  [*] TERMINATING SIMULATION STREAM PROCESSES...
taskkill /f /im ping.exe >nul 2>&1
echo  [=====               ] 25%%
choice /c A /t 1 /d A /n >nul

echo  [*] RE-INDEXING ARBITRATION MAPS (ARP)...
arp -d * >nul 2>&1
echo  [==========          ] 50%%
choice /c A /t 1 /d A /n >nul

echo  [*] FLUSHING CACHED RE-SOLVER ENTRIES...
ipconfig /flushdns >nul 2>&1
echo  [====================] 100%%
choice /c A /t 1 /d A /n >nul

echo.
echo  [!] INFRASTRUCTURE NORMALIZED. RETURNING TO ENVIRONMENT...
choice /c A /t 2 /d A /n >nul
goto :MENU

