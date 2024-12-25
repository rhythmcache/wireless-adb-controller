###########################################
## This file is a part of WirelessADBD-Controller
# by @duds9
###########################################

MODPATH="/data/adb/modules/wadbd"
COMPATH="$MODPATH/common"
SCRIPT_DIR="/data/adb/wadbd"
URL="https://github.com/5ec1cff/KsuWebUIStandalone/releases/download/v1.0/KsuWebUI-1.0-34-release.apk"
APK_DIR="$COMPATH/tmp"
BBPATH="/data/adb/magisk/busybox \
/data/adb/ksu/bin/busybox \
/data/adb/ap/bin/busybox \
/data/adb/modules/busybox-ndk/system/*/busybox"

check_wget() {
    for path in $BBPATH; do
        [ -f "$path" ] && BUSYBOX="$path" && break
    done
    if ! command -v wget >/dev/null || grep -q "wget-curl" "$(command -v wget)"; then
        if [ -n "$BUSYBOX" ]; then
            wget() { "$BUSYBOX" wget "$@"; }
        else
            exit 1
        fi
    fi
}

get_webui() {
    echo "- Downloading the WebUI APK..."
    check_wget
    if ! wget --no-check-certificate -P "$APK_DIR" "$URL"; then
        echo "! Error: APK download failed."
        exit 1
    fi

    echo "- Download complete."
    APK_PATH=$(find "$APK_DIR" -type f -name "*.apk" | head -n 1)
    if [ -z "$APK_PATH" ]; then
        echo "! Error: No APK file found in $APK_DIR."
        exit 1
    fi

    echo "- Installing..."
    if ! pm install -r "$APK_PATH" >/dev/null 2>&1; then
        echo "! Error: APK installation failed."
        rm -f "$APK_PATH"
        exit 1
    fi

    echo "- Done."
    rm -f "$APK_PATH"

    echo "- Launching..."
    if ! am start -n "io.github.a13e300.ksuwebui/.WebUIActivity" -e id "wadbd"; then
        echo "! Error: WebUI launch failed."
        exit 1
    fi

    echo "- Application launched successfully."
}

# Launches KSUWebUI standalone or MMRL, install KSUWebUI standalone if both are not installed
if pm list packages | grep -q "io.github.a13e300.ksuwebui"; then
    echo "- Launching WebUI in KSUWebUIStandalone..."
    am start -n "io.github.a13e300.ksuwebui/.WebUIActivity" -e id "wadbd"
elif pm list packages | grep -q "com.dergoogler.mmrl"; then
    echo "- Launching WebUI in MMRL WebUI..."
    am start -n "com.dergoogler.mmrl/.ui.activity.webui.WebUIActivity" -e MOD_ID "wadbd"
else
    echo "- Installing KSU WebUI..."
    get_webui
fi
