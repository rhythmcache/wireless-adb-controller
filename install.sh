SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=false
REPLACE_EXAMPLE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"
REPLACE="
"

print_modname() {
    ui_print "=================="
    ui_print "      WADBD  "
    ui_print "=================="
}

on_install() {
    ui_print "[*] Starting installation..."
    ui_print ""

    # Print device information
    ui_print "[*] Gathering device information..."
    ui_print "    - Manufacturer: $(getprop ro.product.manufacturer)"
    ui_print "    - Model: $(getprop ro.product.model)"
    ui_print "    - Android Version: $(getprop ro.build.version.release)"
    ui_print "    - Build ID: $(getprop ro.build.id)"
    ui_print "    - Boot Slot: $(getprop ro.boot.slot_suffix)"
    ui_print ""

    # Check if USB debugging is enabled
    ui_print "[*] Checking USB debugging status..."
    adb_status=$(getprop persist.sys.usb.config)
    if echo "$adb_status" | grep -q "adb"; then
        ui_print "    - USB debugging is enabled."
    else
        ui_print "    - USB debugging is NOT enabled."
    fi
    ui_print ""

    # Create module directories and files
    ui_print "[*] Preparing module directory..."
    mkdir -p "$MODPATH/system/bin"
    ui_print ""
    cat <<'EOF' > "$MODPATH/system/bin/wadbd"
#!/system/bin/sh

GREEN='\033[0;32m'
PINK='\033[1;35m'
NC='\033[0m'
usage() {
    echo -e "${PINK}Usage: $(basename "$0") [on|off|status]${NC}"
    exit 1
}
check_root() {
    if [ "$(id -u)" != "0" ]; then
        echo -e "${PINK}Error: This script must be run as root.${NC}"
        exit 1
    fi
}
enable_wireless_adb() {
    setprop service.adb.tcp.port 5555
    stop adbd
    start adbd
    echo -e "${GREEN}Wireless ADB enabled on port 5555.${NC}"
    show_default_gateway
}
disable_wireless_adb() {
    setprop service.adb.tcp.port -1
    stop adbd
    start adbd
    echo -e "${GREEN}Wireless ADB disabled.${NC}"
}
check_wireless_adb_status() {
    port=$(getprop service.adb.tcp.port)
    if [ "$port" = "5555" ]; then
        echo -e "${GREEN}Wireless ADB is enabled on port 5555.${NC}"
        show_default_gateway
    else
        echo -e "${PINK}Wireless ADB is disabled.${NC}"
    fi
}
show_default_gateway() {
    ips=$(ip -f inet addr show | grep -Eo 'inet [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | awk '{print $2}' | grep -v '^127\.0\.0\.1$')
    if [ -n "$ips" ]; then
        echo -e "${PINK}The following commands can be used to connect wirelessly:${NC}"
        for ip in $ips; do
            echo -e "${GREEN}  adb connect $ip${NC}"
        done
    else
        echo -e "${PINK}No usable IP addresses found. Ensure your device is connected to a network.${NC}"
    fi
}
check_root
if [ "$#" -ne 1 ]; then
    usage
fi
case "$1" in
    on)
        enable_wireless_adb
        ;;
    off)
        disable_wireless_adb
        ;;
    status)
        check_wireless_adb_status
        ;;
    *)
        usage
        ;;
esac
EOF

    # Set permissions
    
    ui_print ""
    ui_print "[*] Installation complete!"
}

set_permissions() {
    set_perm_recursive "$MODPATH/system" 0 0 0755 0755
}
ui_print "    - Permissions set successfully."

unity_custom() {
    : # Leave this empty unless adding custom installation/uninstallation logic
}
