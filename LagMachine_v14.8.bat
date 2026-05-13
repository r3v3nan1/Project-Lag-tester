@echo off
setlocal enabledelayedexpansion
title NETWORK MASTER CONTROL v14.8 Stable

:: CONFIG PERSISTENCE PATHS
set "cfg_folder=%temp%\nmc_suite"
if not exist "%cfg_folder%" mkdir "%cfg_folder%"
set "theme_file=%cfg_folder%\theme.dat"
set "skip_file=%cfg_folder%\skip.dat"
set "git_url=https://github.com"

:: LOAD SYSTEM CONFIGS
if exist "%theme_file%" (set /p theme=<"%theme_file%") else (set "theme=02")
if exist "%skip_file%" (set /p always_skip=<"%skip_file%") else (set "always_skip=OFF")

:: FORCE FULLSCREEN & ULTRA ZOOM
if not "%1"=="max" start /max cmd /c %0 max & exit

:: BYPASS ENGINE
if "%always_skip%"=="ON" goto :MENU

:: FAST INTERRUPTIBLE BOOT SEQUENCE
cls & color 02 & echo [ SYSTEM BOOTING... ]
timeout /t 1 >nul
cls & color 0D & echo [ LOADING ENGINE CORES... ]
timeout /t 1 >nul
cls & color 0B & echo [ SYNCING PACKET MATRICES... ]
timeout /t 1 >nul
cls & color 0A & echo [ VERIFYING PROJECT-LAG-TESTER... ]
timeout /t 1 >nul

:MENU
@echo off
color %theme%
cls

:: FAST NETWORK SCRAPING (Combined operations to prevent blocking)
set "my_ip=None" & set "my_gw=None" & set "my_ssid=None" & set "my_sig=None"
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address" /c:"Default Gateway"') do (
    if not defined my_ip (set "my_ip=%%a") else (set "my_gw=%%a")
)
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interfaces ^| findstr /c:" SSID" /c:" Signal"') do (
    if not defined my_ssid (set "my_ssid=%%a") else (set "my_sig=%%a")
)
:: Clean spaces instantly
set "my_ip=%my_ip: =%" & set "my_gw=%my_gw: =%" & set "my_ssid=%my_ssid: =%" & set "my_sig=%my_sig: =%"

echo.
echo +-----------------------------------------------------------+
echo ^|               NETWORK MASTER CONTROL CENTER               ^|
echo ^|               [ VERSION : 14.8 STABLE PRO ]             ^|
echo +-----------------------------------------------------------+
echo ^| IP      : %my_ip%
echo ^| GATEWAY : %my_gw%          SIGNAL : %my_sig%
echo ^| WIFI    : %my_ssid%
echo +-----------------------------------------------------------+
echo.
echo 1. START MONITOR ( Real-Time Live Stream )
echo 2. LIGHT CONGESTION ( 5 Streams )
echo 3. MEDIUM CONGESTION ( 15 Streams )
echo 4. HEAVY FLOOD ( 30 Streams )
echo 5. CUSTOM ATTACK ( Manual Entry )
echo 6. STOP ALL / NUKE ( Deep Reset )
echo 7. SYSTEM SETTINGS ( Engine Matrix )
echo 8. GITHUB REPOSITORY ( Project-Lag-tester )
echo 9. EXIT PROGRAM
echo.
echo +---[ PROJECT DISCLAIMER / TERMS OF USE ]-------------------+
echo ^| This is supposed to be used to test network stability and ^|
echo ^| not for malicious uses. Report bugs to the GitHub repo.  ^|
echo +-----------------------------------------------------------+
echo.
set /p mode=" >> SELECT OPTION: "
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
cls
echo +-----------------------------------------------------------+
echo ^|                 SYSTEM ENGINE OPTIMIZATION                ^|
echo +-----------------------------------------------------------+
echo 1. GREEN  2. AMBER  3. BLUE  4. WHITE
echo 5. AQUA   6. PURPLE 7. RED   8. GRAY
echo.
echo 9. TOGGLE ALWAYS SKIP [CURRENT: %always_skip%]
echo 10. RETURN TO MENU
echo.
set /p s_choice=" >> CONFIG SELECTION ID: "
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
echo.
set /p win=" [?] Windows: "
set /p cnt=" [?] Count: "
set /p psize=" [?] Packet Size: "
goto :LAUNCH

:LAUNCH
cls
echo +-----------------------------------------------------------+
echo   LAUNCHING STREAMS ASYNCHRONOUSLY... Please Wait.
echo +-----------------------------------------------------------+
:: Ultra-fast asynchronous loop spawn without nested calculations
for /L %%i in (1,1,%win%) do (
    start /min cmd /c "color %theme% && ping %my_gw% -t -n %cnt% -l %psize% -w 1"
)
goto :MENU

:CHECKER
cls
set /p t_ip=" >> TARGET IP (Press ENTER for Gateway %my_gw%): "
if "!t_ip!"=="" set "t_ip=%my_gw%"

:C_LOOP
cls
echo +-----------------------------------------------------------+
echo ^| LIVE REFRESH DIAL: %t_ip% [PRESS CTRL+C TO EXIT]        ^|
echo +-----------------------------------------------------------+
ping -n 2 -w 1000 %t_ip%
goto :C_LOOP

:NUKE
cls & color 0C
echo +-----------------------------------------------------------+
echo ^|                   PURGING ENGINE RUNTIMES                 ^|
echo +-----------------------------------------------------------+
echo [*] TERMINATING SIMULATION STREAM PROCESSES...
taskkill /f /im ping.exe >nul 2>&1
echo [*] RE-INDEXING ARBITRATION MAPS (ARP)...
arp -d * >nul 2>&1
echo [*] FLUSHING CACHED RE-SOLVER ENTRIES...
ipconfig /flushdns >nul 2>&1
echo [====================] 100%%
timeout /t 1 >nul
goto :MENU

