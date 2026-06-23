@echo off
:: 1. Build your project (This assumes you are using the command-line build)
:: If you prefer, just build in IDE, then run this to flash everything
echo Flashing Firmware and Splash Screen...

:: Flash the Firmware (Firmware + Partition Table)
"%LOCALAPPDATA%\Arduino15\packages\esp32\tools\esptool_py\4.2.1\esptool.exe" --chip esp32s3 --port COM15 --baud 921600 write_flash 0x0 DomeControlFirmware.ino.bin 0x8000 DomeControlFirmware.ino.partitions.bin 0xe000 boot_app0.bin

:: Flash the SPIFFS (Splash Screen)
"%LOCALAPPDATA%\Arduino15\packages\esp32\tools\esptool_py\4.2.1\esptool.exe" --chip esp32s3 --port COM15 --baud 921600 write_flash 0x290000 spiffs.bin

echo Done!
pause