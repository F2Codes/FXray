#!/bin/bash

# FXray Installer + Launcher

# لوگوی FXray
echo -e '\e[96m

  (        )                   
 )\ )  ( /(                   
(()/(  )\()) (       )  (     
 /(_))((_)\  )(   ( /(  )\ )  
(_))_|__((_)(()\  )(_))(()/(  
| |_  \ \/ / ((_)((_)_  )(_)) 
| __|  >  < | '_|/ _` || || | 
|_|   /_/\_\|_|  \__,_| \_, | 
                        |__/  
\e[0m'


echo -e "\e[96mFXray Installer & Launcher\e[0m\n"

INSTALL_PATH="/usr/local/bin"
GEO_URL="https://example.com/fxray/geo.dat"
XRAY_CONFIG="$INSTALL_PATH/config.json"

# نصب هسته Xray
install_core() {
    echo -e "\e[96mDownloading FXray core...\e[0m"
    LATEST_URL=$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases/latest \
        | grep browser_download_url \
        | grep linux-64.zip \
        | cut -d '"' -f 4)
    curl -L -o /tmp/fxray-core.zip "$LATEST_URL"
    unzip -o /tmp/fxray-core.zip -d /tmp/fxray-core
    cp /tmp/fxray-core/xray "$INSTALL_PATH/fxray"
    chmod +x "$INSTALL_PATH/fxray"
    echo -e "\e[96mFXray core installed successfully!\e[0m"
}

# دانلود فایل Geo
update_geo() {
    echo -e "\e[96mDownloading geo file...\e[0m"
    curl -L -o "$INSTALL_PATH/geo.dat" "$GEO_URL"
    echo -e "\e[96mGeo file updated!\e[0m"
}

# پاک‌سازی کامل
remove_fxray() {
    echo -e "\e[96mRemoving FXray...\e[0m"
    rm -f "$INSTALL_PATH/fxray"
    rm -f "$INSTALL_PATH/geo.dat"
    rm -f "$XRAY_CONFIG"
    echo -e "\e[96mFXray removed!\e[0m"
}

# اجرای Xray
run_xray() {
    if [ -f "$XRAY_CONFIG" ]; then
        echo -e "\e[96mStarting Xray...\e[0m"
        nohup "$INSTALL_PATH/fxray" -c "$XRAY_CONFIG" >/dev/null 2>&1 &
        echo -e "\e[96mXray is running in background.\e[0m"
        echo -e "\e[96mSocks5 Proxy: 127.0.0.1:1080\e[0m"
    else
        echo -e "\e[91mXray config not found. Please install first.\e[0m"
    fi
}

# منوی اصلی
main_menu() {
    while true; do
        echo -e "\n\e[96mSelect an option:\e[0m"
        echo -e "\e[96m1) Install FXray\e[0m"
        echo -e "\e[96m2) Update FXray\e[0m"
        echo -e "\e[96m3) Remove FXray\e[0m"
        echo -e "\e[96m4) Run Xray\e[0m"
        echo -e "\e[96m5) Exit\e[0m"
        read -p "Enter your choice [1-5]: " choice
        case $choice in
            1) install_core; update_geo ;;
            2) install_core; update_geo ;;
            3) remove_fxray ;;
            4) run_xray ;;
            5) echo -e "\e[96mGoodbye!\e[0m"; exit 0 ;;
            *) echo -e "\e[91mInvalid option, try again!\e[0m" ;;
        esac
    done
}

main_menu
