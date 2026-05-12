@echo off
setlocal enabledelayedexpansion
title NETWORK MASTER CONTROL v14.4

:: BOOT CONFIG
set "theme_file=%temp%\nmc_config.dat"
set "git_url=https://github.com"
:: ULTRA ZOOM FONT (Height 30, Width 48)
set "z_h=30" & set "z_w=48"

:: LOAD SAVED THEME
if exist "%theme_file%" (set /p theme=<"%theme_file%") else (set "theme=02")

:: FORCE FULLSCREEN & ULTRA ZOOM
if not "%1"=="max" start /max cmd /c %0 max & exit
powershell -command "& { $p = Get-Process -Id $pid; $h = $p.MainWindowHandle; $s = [Windows.Win32.PInvoke]::GetWindowLong($h, -16); $s = $s -band -xor 0x00C00000; [Windows.Win32.PInvoke]::SetWindowLong($h, -16, $s); [Windows.Win32.PInvoke]::ShowWindow($h, 3); $config = Get-Host; $config.UI.RawUI.FontSize = New-Object System.Management.Automation.Host.Size(%z_h%,%z_w%) }" >nul 2>&1

:: EXTENDED STARTUP ANIMATION (6 Seconds)
cls & color 02
echo. & echo   [ SYSTEM BOOTING ] & ping 127.0.0.1 -n 2 >nul
cls & color 0D
echo. & echo   [ LOADING CORE RESOURCES ] & ping 127.0.0.1 -n 2 >nul
cls & color 0B
echo. & echo   [ SYNCING NETWORK PROTOCOLS ] & ping 127.0.0.1 -n 2 >nul
cls & color 0A
echo. & echo   [ AUTHORIZING PROJECT-LAG-TESTER ] & ping 127.0.0.1 -n 2 >nul
cls & color %theme%

:MENU
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
echo  ^|             [ VERSION : 14.4 Beta ]                       ^|
echo  +-----------------------------------------------------------+
echo  ^|  IP      : %my_ip%                                        
echo  ^|  GATEWAY : %my_gw%          SIGNAL    : %my_sig%           
echo  ^|  WIFI    : %my_ssid%                                      
echo  +-----------------------------------------------------------+
echo.
echo      1. START MONITOR      ( Graphical Tracker )
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
echo      7. VISUAL SETTINGS    ( Color Matrix )
echo.
echo      8. GITHUB REPOSITORY  ( r3v3nan1 )
echo.
echo      9. EXIT PROGRAM
echo.
echo  +---[ v14.2 CHANGELOG ]-------------------------------------+
echo  ^| + Increased Font Size to 30x48 for Ultra-Zoom            ^|
echo  ^| + Restored 1-9 Vertical Numbered Menu                     ^|
echo  ^| + Maintained 6-Second Color Boot Sequence                ^|
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
if "%mode%"=="8" start %git_url% & goto :MENU
if "%mode%"=="9" exit
goto :MENU

:SETTINGS
cls
echo.
echo  +-----------------------------------------------------------+
echo  ^|                VISUAL THEME SELECTION                     ^|
echo  +-----------------------------------------------------------+
echo.
echo     1. GREEN     2. AMBER     3. BLUE     4. WHITE
echo.
echo     5. AQUA      6. PURPLE    7. RED      8. GRAY
echo.
echo     9. RETURN TO MENU
echo.
set /p s_choice="  >> CHOOSE COLOR ID: "
if "%s_choice%"=="1" set "theme=02"
if "%s_choice%"=="2" set "theme=06"
if "%s_choice%"=="3" set "theme=09"
if "%s_choice%"=="4" set "theme=0F"
if "%s_choice%"=="5" set "theme=0B"
if "%s_choice%"=="6" set "theme=0D"
if "%s_choice%"=="7" set "theme=04"
if "%s_choice%"=="8" set "theme=08"
if "%s_choice%"=="9" goto :MENU
echo %theme%>"%theme_file%"
goto :MENU

:LAUNCH
cls
echo.
echo  +-----------------------------------------------------------+
echo  ^|              INITIALIZING NETWORK STREAMS                 ^|
echo  +-----------------------------------------------------------+
echo.
for /L %%i in (1,1,%win%) do (
    set /a "perc=(%%i*100)/%win%"
    set "load_bar=" & set /a "blocks=!perc!/5"
    for /L %%b in (1,1,!blocks!) do set "load_bar=!load_bar!="
    start /high /min cmd /c "color %theme% && ping %my_gw% -n %cnt% -l %psize% -w 1"
    cls
    echo.
    echo  +-----------------------------------------------------------+
    echo    DEPLOYING: %%i / %win%     PROGRESS : [!load_bar!] !perc!%%
    echo.
    ping 127.0.0.1 -n 1 >nul
)
goto :MENU

:CHECKER
set "max_ping=0" & set "lost_packets=0" & set "total_packets=0" 
set "last_ms=0" & set "jitter=0" & set "max_jitter=0"
set /p t_ip="  >> TARGET IP (ENTER FOR GATEWAY): "
if "!t_ip!"=="" set "t_ip=%my_gw%"
:C_LOOP
set "ping_found=OFF" & set /a total_packets+=1
for /f "tokens=4 delims==" %%a in ('ping -n 1 -w 1000 %t_ip% ^| findstr "time="') do (
    set "ms_text=%%a" & set "ms=!ms_text:ms=!" & set "ms=!ms: =!"
    set "ping_found=ON"
    if !ms! GTR !max_ping! set "max_ping=!ms!"
    set /a "jitter=!ms! - !last_ms!"
    if !jitter! LSS 0 set /a "jitter=0 - !jitter!"
    if !jitter! GTR !max_jitter! set "max_jitter=!jitter!"
    set "last_ms=!ms!"
)
if "!ping_found!"=="OFF" set /a lost_packets+=1 & set "ms=999"
cls
echo.
echo  +-----------------------------------------------------------+
echo  ^|  TRACKING: %t_ip%                   [M] MENU  ^|
echo  +-----------------------------------------------------------+
echo.
echo     LATENCY : !ms!ms        JITTER : !jitter!ms
echo     MAX SPIKE: !max_ping!ms        MAX JIT: !max_jitter!ms
echo     LOSS    : !lost_packets!/!total_packets!
echo.
echo  +-----------------------------------------------------------+
echo.
set "bar="
if "!ping_found!"=="ON" (
    set /a "bars=!ms! / 12"
    if !bars! GTR 62 set "bars=62"
    for /L %%g in (1,1,!bars!) do set "bar=!bar!="
    echo   [!bar!]
) else (
    echo   [ !!! PACKET LOST !!! ]
)
echo.
if "!ping_found!"=="OFF" (color 0C) else (color %theme%)
choice /c CM /t 1 /d C /n >nul
if errorlevel 2 goto :MENU
goto :C_LOOP

:NUKE
cls & color 0C
echo  [*] EXECUTING DEEP PURGE...
taskkill /f /im ping.exe >nul 2>&1
arp -d * >nul 2>&1
ipconfig /flushdns >nul 2>&1
ping 127.0.0.1 -n 3 >nul
goto :MENU
