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

Note: If you don't specify a port, it will use the default port 5555.
```

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

