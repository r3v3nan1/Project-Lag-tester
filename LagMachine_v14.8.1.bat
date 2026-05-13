@echo off
setlocal enabledelayedexpansion
title NETWORK TOOLS PANEL

:: CONFIG PERSISTENCE PATHS
set "cfg_folder=%temp%\nmc_suite"
if not exist "%cfg_folder%" mkdir "%cfg_folder%"
set "theme_file=%cfg_folder%\theme.dat"
set "skip_file=%cfg_folder%\skip.dat"
set "target_file=%cfg_folder%\target.dat"
set "log_file=%cfg_folder%\stream_activity.log"
set "git_url=https://github.com/r3v3nan1/Project-Lag-tester"

:: LOAD SYSTEM CONFIGS
if exist "%theme_file%" (set /p theme=<"%theme_file%") else (set "theme=02")
if exist "%skip_file%" (set /p always_skip=<"%skip_file%") else (set "always_skip=OFF")
if exist "%target_file%" (set /p custom_target=<"%target_file%") else (set "custom_target=")

:: BYPASS ENGINE
set "clean_skip=%always_skip: =%"
if /i "%clean_skip%"=="ON" goto :MENU

:: FORCE FULLSCREEN & ULTRA ZOOM
if not "%1"=="max" start /max cmd /c %0 max & exit

:: FAST INTERRUPTIBLE BOOT SEQUENCE
cls & color 02 & echo [ LOADING APP... ]
timeout /t 1 >nul

:MENU
@echo off
color %theme%
cls

:: SYSTEM NETWORK INFORMATION FETCH
set "my_ip=Scanning..." & set "my_gw=Scanning..." & set "my_ssid=Scanning..." & set "my_sig=Scanning..."
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address" /c:"Default Gateway"') do (
    if "!my_ip!"=="Scanning..." (set "my_ip=%%a") else (set "my_gw=%%a")
)
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interfaces ^| findstr /c:" SSID" /c:" Signal"') do (
    if "!my_ssid!"=="Scanning..." (set "my_ssid=%%a") else (set "my_sig=%%a")
)
set "my_ip=%my_ip: =%" & set "my_gw=%my_gw: =%" & set "my_ssid=%my_ssid: =%" & set "my_sig=%my_sig: =%"

:: Set default fallback if no custom profile ip is assigned
set "active_target=%custom_target%"
if "%active_target%"=="" set "active_target=%my_gw%"

:MENU_REFRESH
cls
:: COUNT ACTIVE RUNNING STREAMS
set "active_streams=0"
for /f %%a in ('tasklist /nh /fi "imagename eq ping.exe" ^| findstr /i "ping.exe"') do set /a active_streams+=1

echo ============================================================
echo   NETWORK STATUS SUMMARY
echo ============================================================
echo   [+] Your IP:       %my_ip%
echo   [+] Gateway:       %my_gw%
echo   [+] Wi-Fi Name:    %my_ssid% (Signal: %my_sig%)
echo   [+] Active Target: %active_target%
echo   [+] Background Tasks Running: [ %active_streams% ]
echo ============================================================
echo.
echo   [ QUICK ACTIONS ]
echo   0. REFRESH DASHBOARD (Manually update counts)
echo.
echo   [ MONITORING TOOLS ]
echo   1. Start Continuous Live Test (Checks for Packet Drops)
echo.
echo   [ STABILITY STRESS EXPERIMENTS ]
echo   2. Run Small Load   (5 Streams  ^| 100 Packets each)
echo   3. Run Medium Load  (15 Streams ^| 500 Packets each)
echo   4. Run Heavy Load   (30 Streams ^| 1000 Packets each)
echo   5. Custom Setup     (Choose your own limits manually)
echo.
echo   [ SYSTEM MANAGEMENT ]
echo   6. Emergency Stop   (Kill all test streams ^& clear logs)
echo   7. Open Settings    (Colors, Skip screen, Set Custom Target)
echo   8. Open GitHub Link (View project online)
echo   9. Close Program
echo.
echo ============================================================
set "mode="
:: Changed choice parameter to stop automatic timer looping
choice /c 0123456789 /n >nul
if errorlevel 10 exit
if errorlevel 9 start "" "%git_url%" & goto :MENU
if errorlevel 8 goto :SETTINGS
if errorlevel 7 goto :NUKE
if errorlevel 6 goto :CUSTOM
if errorlevel 5 set "win=30" & set "cnt=1000" & set "psize=64000" & goto :LAUNCH
if errorlevel 4 set "win=15" & set "cnt=500" & set "psize=64000" & goto :LAUNCH
if errorlevel 3 set "win=5" & set "cnt=100" & set "psize=64000" & goto :LAUNCH
if errorlevel 2 goto :CHECKER
if errorlevel 1 goto :MENU_REFRESH

:SETTINGS
cls
echo ============================================================
echo   SYSTEM SETTINGS ENGINE
echo ============================================================
echo   [ DISPLAY COLOR OPTIONS ]
echo   1. Green   2. Amber   3. Blue   4. White
echo   5. Aqua    6. Purple  7. Red    8. Gray
echo.
echo   [ CONFIGURATION PERSISTENCE ]
echo   9. Skip Startup Loading Screen  [Currently: %always_skip%]
echo   10. Change Saved Custom Target  [Current: %active_target%]
echo   11. Open System Log File (View Drop History)
echo   12. Back to Main Menu
echo ============================================================
set "s_choice="
set /p s_choice=" >> SELECT SETTING OPTION (1-12): "
if "%s_choice%"=="1" set "theme=02" & echo 02>"%theme_file%" & goto :MENU
if "%s_choice%"=="2" set "theme=06" & echo 06>"%theme_file%" & goto :MENU
if "%s_choice%"=="3" set "theme=09" & echo 09>"%theme_file%" & goto :MENU
if "%s_choice%"=="4" set "theme=0F" & echo 0F>"%theme_file%" & goto :MENU
if "%s_choice%"=="5" set "theme=0B" & echo 0B>"%theme_file%" & goto :MENU
if "%s_choice%"=="6" set "theme=0D" & echo 0D>"%theme_file%" & goto :MENU
if "%s_choice%"=="7" set "theme=04" & echo 04>"%theme_file%" & goto :MENU
if "%s_choice%"=="8" set "theme=08" & echo 08>"%theme_file%" & goto :MENU
if "%s_choice%"=="9" (
    if /i "%always_skip%"=="ON" (
        set "always_skip=OFF"
        <nul set /p="OFF">"%skip_file%"
    ) else (
        set "always_skip=ON"
        <nul set /p="ON">"%skip_file%"
    )
    goto :SETTINGS
)
if "%s_choice%"=="10" (
    echo.
    set /p "new_targ= >> Enter New Target IP or Domain (Leave blank to clear): "
    if "!new_targ!"=="" (
        if exist "%target_file%" del "%target_file%" >nul 2>&1
        set "custom_target="
    ) else (
        set "custom_target=!new_targ!"
        <nul set /p="!new_targ!">"%target_file%"
    )
    goto :MENU
)
if "%s_choice%"=="11" (
    if exist "%log_file%" ( start notepad.exe "%log_file%" ) else ( echo No logs found yet. & timeout /t 2 >nul )
    goto :SETTINGS
)
if "%s_choice%"=="12" goto :MENU
goto :SETTINGS

:CUSTOM
echo.
echo --- CUSTOM SETUP CONSOLE ---
set /p win=" [?] How many background windows to launch?: "
set /p cnt=" [?] How many packets per window?       : "
set /p psize=" [?] Size of individual packet (bytes)  : "
goto :LAUNCH

:LAUNCH
cls
echo ============================================================
echo   STARTING STREAMS... PLEASE WAIT.
echo ============================================================
echo [%date% %time%] Launched %win% streams. Target: %active_target%. Count: %cnt%. Size: %psize% bytes. >> "%log_file%"
for /L %%i in (1,1,%win%) do (
    start /min cmd /c "color %theme% && ping %active_target% -t -n %cnt% -l %psize% -w 1"
)
goto :MENU

:CHECKER
set "t_ip=%active_target%"
set "total_pings=0"
set "dropped_pings=0"
set "loss_percent=0"

:C_LOOP
cls
set /a total_pings+=1

echo ============================================================
echo   LIVE MONITORING FEED: %t_ip%
echo   [ HOLD DOWN THE 'M' KEY TO EXIT BACK TO MAIN MENU ]
echo ============================================================
echo   TOTAL TESTS SENT : %total_pings%
echo   PACKETS DROPPED  : %dropped_pings%
echo   CURRENT DROP RATE: %loss_percent%%%
echo ============================================================
echo.

set "ping_error=0"
ping -n 1 -w 800 %t_ip% | findstr /i "timed out expired unreachable failed" >nul && set "ping_error=1"

if "%ping_error%"=="1" (
    set /a dropped_pings+=1
    echo [%date% %time%] DROP IDENTIFIED on Target %t_ip% >> "%log_file%"
)

set /a "loss_percent=(dropped_pings * 100) / total_pings"

echo.
echo ============================================================
choice /c CM /t 1 /d C /n >nul
if errorlevel 2 goto :MENU
goto :C_LOOP

:NUKE
cls & color 0C
echo ============================================================
echo   RESETTING APP CONSOLE
echo ============================================================
echo [*] Closing background windows...
taskkill /f /im ping.exe >nul 2>&1
echo [*] Re-indexing ARP maps...
arp -d * >nul 2>&1
echo [*] Flushing DNS cache logs...
if exist "%log_file%" del /f /q "%log_file%" >nul 2>&1
echo [====================] 100%% Successfully Cleaned.
timeout /t 2 >nul
goto :MENU
