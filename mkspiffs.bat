@echo off
setlocal

set PORT=COM15
set FLASH_SIZE=0x170000
set OFFSET=0x290000

if "%PORT%"=="" (
	echo Usage: mkspiffs.bat COM15
	exit /b 1
)

echo Building SPIFFS image...
%LOCALAPPDATA%\Arduino15\packages\esp32\tools\mkspiffs\0.2.3\mkspiffs.exe -c data32 -b 4096 -p 256 -s %FLASH_SIZE% spiffs.bin

if errorlevel 1 (
	echo mkspiffs failed
	exit /b 1
)

echo Flashing SPIFFS to %PORT%...
%LOCALAPPDATA%\Arduino15\packages\esp32\tools\esptool_py\4.2.1\esptool.exe --chip esp32s3 --port %PORT% --baud 921600 write_flash %OFFSET% spiffs.bin

echo Done.
endlocal