#!/bin/bash

# ================================
# FXray Installer for Linux / Mac
# ================================

# لوگوی FXray – می‌توانید ASCII خودتان را جایگزین کنید
echo -e "\e[96m
  :::===== :::  === :::====  :::====  ::: ===
 :::      :::  === :::  === :::  === ::: ===
 ======    ======  =======  ========  ===== 
 ===       ======  === ===  ===  ===   ===  
 ===      ===  === ===  === ===  ===   ===  
                                            
\e[0m"

echo -e "\e[96mFXray Installer - Multi-platform Xray Installer\e[0m"
echo ""

# ================================
# تنظیمات از default.json
# ================================
INSTALL_PATH="/usr/local/bin"
GEO_URL="https://example.com/fxray/geo.dat"

# ================================
# تابع نصب هسته FXray/Xray
# ================================
install_core() {
    echo -e "\e[96mDownloading FXray core...\e[0m"

    # دریافت آخرین نسخه Xray-core از GitHub
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

# ================================
# تابع دانلود و آپدیت فایل geo
# ================================
update_geo() {
    echo -e "\e[96mDownloading geo file...\e[0m"
    curl -L -o "$INSTALL_PATH/geo.dat" "$GEO_URL"
    echo -e "\e[96mGeo file updated!\e[0m"
}

# ================================
# تابع پاک‌سازی کامل FXray
# ================================
remove_fxray() {
    echo -e "\e[96mRemoving FXray...\e[0m"
    rm -f "$INSTALL_PATH/fxray"
    rm -f "$INSTALL_PATH/geo.dat"
    echo -e "\e[96mFXray removed!\e[0m"
}

# ================================
# منوی رنگی اصلی
# ================================
main_menu() {
    while true; do
        echo -e "\e[96mSelect an option:\e[0m"
        echo -e "\e[96m1) Install FXray\e[0m"
        echo -e "\e[96m2) Update FXray\e[0m"
        echo -e "\e[96m3) Remove FXray\e[0m"
        echo -e "\e[96m4) Exit\e[0m"
        read -p "Enter your choice [1-4]: " choice
        case $choice in
            1) install_core; update_geo ;;
            2) install_core; update_geo ;;
            3) remove_fxray ;;
            4) echo -e "\e[96mGoodbye!\e[0m"; exit 0 ;;
            *) echo -e "\e[91mInvalid option, try again!\e[0m" ;;
        esac
        echo ""
    done
}

# ================================
# اجرای منو
# ================================
main_menu
