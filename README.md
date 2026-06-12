# FORK Information

## Reason:
This fork was created to improve compatibility with DroidLink-based Astromech control systems.

The original Roam-A-Dome firmware includes a packet serial communications watchdog that stops dome movement if no valid serial command is received within 1.5 seconds (PACKET_SERIAL_TIMEOUT = 1500). This behavior is intended as a safety feature to prevent uncontrolled dome movement in the event of a lost communications link.

During testing with DroidLink, it was observed that packet serial commands are transmitted when joystick values change, but continuous commands do not appear to be sent while the joystick remains in a fixed position. As a result, Roam-A-Dome interprets the lack of incoming serial data as a loss-of-signal (LOS) condition and stops dome rotation approximately 1.5 seconds after the last command is received.

## Scope: 
The packet serial watchdog timeout was increased from:

		#define PACKET_SERIAL_TIMEOUT 1500

			to:

		#define PACKET_SERIAL_TIMEOUT 10000

No other functionality or control logic was modified.

## Results:
Increasing the watchdog timeout to 10 seconds preserves the original safety mechanism while allowing normal operation with DroidLink packet serial control. Dome rotation now continues correctly when the joystick is held at a constant position, while the firmware still provides an automatic shutdown if communications are lost for an extended period.

This change was validated through bench testing using DroidLink packet serial output and a Syren motor controller. Dome movement remained responsive to all control inputs, and the previous 1.5-second shutdown behavior was eliminated.

 
## Origional DomeControlFirmware Documentation
(https://github.com/reeltwo/DomeControlFirmware)
