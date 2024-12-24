ui_print "[*] Checking USB debugging status..."
if getprop persist.sys.usb.config | grep -q "adb"; then
    ui_print "    - USB debugging is enabled."
else
    ui_print "    - USB debugging is NOT enabled."
fi

ui_print ""
ui_print " => 🔍 Gathering device information..."
sleep 1

# Gather and display device information
ui_print "📱 => Manufacturer: $(getprop ro.product.manufacturer)"
ui_print "📱 => Model: $(getprop ro.product.model)"
ui_print "📱 => Android Version: $(getprop ro.build.version.release)"
ui_print "📱 => Security Patch: $(getprop ro.build.version.security_patch)"
ui_print "🔧 => Build Fingerprint: $(getprop ro.build.fingerprint)"

sleep 1

ui_print "✨=====================================✨"
ui_print "💅 =>Starting installation process..."

# Set permissions recursively
set_perm_recursive "$MODPATH/system" 0 0 0755 0755
