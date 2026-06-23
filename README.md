# FORK Information

## Reason:
This fork was created to improve compatibility with DroidLink-based Astromech control systems.

The original Roam-A-Dome firmware includes a packet serial communications watchdog that stops dome movement if no valid serial command is received within a fixed timeout window (default behavior in upstream firmware). This is intended as a safety feature to prevent uncontrolled dome movement in the event of a lost communications link.

During testing with DroidLink, it was observed that packet serial commands are only transmitted when joystick values change. When the joystick remains in a steady position, no continuous updates are sent. As a result, the firmware interprets this as a loss-of-signal (LOS) condition and stops dome rotation after the timeout period.

## Hardware Compatibility

This firmware is specifically intended for the **ESP32-S3 Dome Control PCB variant with built-in display and no control wheel/encoder**.

<img width="218" height="133" alt="RAD-OLED" src="https://github.com/user-attachments/assets/1d89f5d6-17af-4e03-a917-df519ec430e8" />

### Supported hardware:
- ESP32-S3 based Dome Control board
- Integrated onboard display (factory-installed)
- No rotary encoder / control wheel present
- USB-C native programming (ESP32-S3 native USB)

### Not supported:
- Older Dome Control boards with:
  - external control wheel / rotary encoder
  - alternate button layout
  - legacy ESP32 (non-S3) variants
  - earlier full-size or compact PCB revisions without onboard display

This fork assumes the display-integrated UI version of the hardware and may not function correctly on earlier control board revisions due to differences in input handling and hardware configuration.

## Changes Made

### 1. Packet Serial Timeout is now configurable

The original fixed timeout:

#define PACKET_SERIAL_TIMEOUT 1500

has been replaced with a **user-configurable runtime value** exposed in the UI.

### Default behavior:
- Default timeout: **1500 ms** (same as upstream firmware behavior)
- Minimum value: **0 ms** (disabled / no watchdog timeout)
- Maximum value: **30000 ms** (30 seconds)

This allows users to tune responsiveness depending on their control system behavior.

### 2. UI Control Added

The firmware now exposes the timeout setting directly in the web UI.

Users can:
- Increase timeout for slower / non-continuous control systems (e.g. DroidLink)
- Disable timeout completely for testing (0)
- Restore safe default behavior (1500 ms)

Settings are saved and persist across reboot.

<img width="288" height="623" alt="Screenshot_20260613-061126" src="https://github.com/user-attachments/assets/067e7bd8-8fb5-43c2-9b40-f60a0f134f55" />

### 3. Safety Behavior

The watchdog system remains active by default.

Even with extended timeout values, the system will still:
- Stop dome motion if communication is lost beyond the configured threshold
- Prevent uncontrolled motor behavior in signal loss conditions

Setting timeout to `0` disables this safety stop (use with caution).

## Web Installer Support

This fork now includes a **browser-based firmware installer** using ESP Web Tools.

Users can flash the firmware directly from a web page:

- No Arduino IDE required
- No manual esptool usage required
- One-click install via Chrome / Edge

### Web installer includes:
- Full firmware flashing (bootloader + partitions + app)
- Automatic erase option during install
- ESP32-S3 compatible manifest

## Flash Method Compatibility

### Supported methods:
- Arduino IDE upload (fully supported)
- Web installer (recommended for end users)
- esptool.py manual flashing

### Notes:
- Web installer uses the same compiled binaries as Arduino IDE builds
- SPIFFS/splash image still requires separate upload step (if applicable in this fork)

## Web Installer: 
https://cosplay-ken.github.io/DomeControlFirmware-Prod/

## Original Project:
https://github.com/reeltwo/DomeControlFirmware
