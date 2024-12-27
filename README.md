# Wireless ADB Controller  
A simple Magisk module to control the Wireless ADB daemon.

## How to Use  
1. Install the module via **Magisk**, **KernelSU**, or **Apatch**.  
2. Reboot your device.  
3. Open **Termux** or a terminal emulator and run the following command as `su`.

---
## Commands  
```
Usage: wadbd [on <port>|off|status|enable-on-boot <port>|disable-on-boot]

Commands:
  wadbd on <port>              - Enable wireless ADB on the specified port.
  wadbd off                   - Disable wireless ADB.
  wadbd status                - Show the status of wireless ADB.
  wadbd enable-on-boot <port> - Enable wireless ADB on boot with the specified port.
  wadbd disable-on-boot       - Disable wireless ADB on boot.
wadbd --import-key <path>   - Import an adbkey.pub file to authorize ADB without prompt.

Note: If you don't specify a port, it will use the default port 5555.
```
# WebUI

- You Can Also Control This Module Using Kernel Su or Apatch WebUI

## WebUI Screenshot

<div style="display: flex; justify-content: center; align-items: center;">
  <img src="https://github.com/rhythmcache/wireless-adb-controller/raw/main/Screenshot_20241224-232657.png" alt="WebUI Screenshot" width="45%">
  <img src="https://github.com/rhythmcache/wireless-adb-controller/raw/main/Screenshot_20241227-081225_KernelSU.png" alt="KernelSU Screenshot" width="45%">
</div>


# Terminal Commands

### `wadbd on [port] `
- Enables Wireless ADB on specified port and displays the necessary commands to connect to your phone wirelessly.
- default port is 5555 if not specified while running the command

### `wadbd status`  
- Displays whether Wireless ADB is currently running or not.

### `wadbd off`  
- Disables Wireless ADB.

### `wadbd enable-on-boot [port]`
- enables wireless adbd automatically on boot on specified port
(default 5555 if not specified)

### `wadbd disable-on-boot`
- Disables wirelss adbd on boot

#### `wadbd --import-key <path to adbkey.pub>`
- If your device is not prompting to authorize ADB for some reason, you can use this to directly import ADB keys to authorize your device.
- This might not work on all devices.

---
## License

    This Script Is Free Software. You can redistribute it
    and/or modify it under the terms of the GNU General Public
    License as published by the Free SoftwareFoundation,either version 3 of the License , or (at your option) 
    any later version.

    This script is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this script.  If not, see <http://www.gnu.org/licenses/>.
    
[![Telegram](https://img.shields.io/badge/Telegram-Join%20Chat-blue?style=flat-square&logo=telegram)](https://t.me/ximistuffschat)
![Downloads](https://img.shields.io/github/downloads/Magisk-Modules-Alt-Repo/wadbd/total.svg)
