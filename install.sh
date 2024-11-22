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
    ui_print "✨=====================================✨"
    ui_print "🌟 Wireless ADBD Controller.  🌟"
    ui_print "✨=====================================✨"
}
debugging() {
    ui_print "[*] Checking USB debugging status..."
    adb_status=$(getprop persist.sys.usb.config)
    if echo "$adb_status" | grep -q "adb"; then
        ui_print "    - USB debugging is enabled."
    else
        ui_print "    - USB debugging is NOT enabled."
    fi
    ui_print ""
    }
print_device_info() {
    ui_print "🔍 Gathering device information..."
    ui_print "📱 Manufacturer: $(getprop ro.product.manufacturer)"
    ui_print "📱 Model: $(getprop ro.product.model)"
    ui_print "📱 Android Version: $(getprop ro.build.version.release)"
    ui_print "📱 Security Patch: $(getprop ro.build.version.security_patch)"
    ui_print "🔧 Build Fingerprint: $(getprop ro.build.fingerprint)"
    ui_print "✨=====================================✨"
}

on_install() {
    ui_print "🚀 Starting installation process..."
    ui_print "📂 Extracting module files..."
    unzip -o "$ZIPFILE" "system/*" -d "$MODPATH" >&2
}
set_permissions() {
    set_perm_recursive "$MODPATH/system" 0 0 0755 0755
}

print_modname
print_device_info
debugging
on_install
set_permissions
