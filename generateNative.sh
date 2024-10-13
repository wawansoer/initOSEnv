#!/bin/bash

# Cek apakah jumlah argumen sudah sesuai
if [ "$#" -ne 4 ]; then
    echo "Penggunaan: $0 <app_name> <app_url> <app_description> <icon_path>"
    exit 1
fi

# Ambil argumen dari input
APP_NAME="$1"
APP_URL="$2"
APP_DESCRIPTION="$3"
ICON_PATH="$4"
APP_VERSION="1.0.0"

# Instal Nativefier jika belum diinstal
if ! command -v nativefier &> /dev/null; then
    echo "Nativefier tidak ditemukan. Menginstal..."
    npm install -g nativefier
fi

# Membangun aplikasi menggunakan Nativefier dengan pengaturan keamanan
echo "Membuat aplikasi $APP_NAME dari $APP_URL..."
nativefier \
    --name "$APP_NAME" \
    --user-agent "Mozilla/5.0 (X11; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0" \
    --icon "$ICON_PATH" \
    --disable-dev-tools \
    --single-instance \
    --file-download-options '{"saveAs": true}' \
    --internal-urls ".*?(google\.com|accounts\.google\.com|googleapis\.com)" \
    --strict-internal-urls \
    --lang "en-US" \
    --verbose \
    --app-version "1.0.0" \
    --darwin-dark-mode-support \
    --fast-quit \
    --background-color "#ffffff" \
    --disable-old-build-warning-yesiknowitisinsecure \
    --overwrite \
    "$APP_URL"

# Buat struktur folder untuk paket Debian
echo "Membuat struktur folder untuk paket Debian..."
mkdir -p "$APP_NAME/DEBIAN"
mkdir -p "$APP_NAME/usr/local/bin/$APP_NAME"
mkdir -p "$APP_NAME/usr/share/applications"
mkdir -p "$APP_NAME/usr/share/icons/hicolor/512x512/apps"

# Salin aplikasi ke dalam struktur paket
echo "Menyalin aplikasi ke dalam struktur paket..."
cp -r "$APP_NAME-linux-x64/"* "$APP_NAME/usr/local/bin/$APP_NAME/"

# Buat file kontrol Debian
echo "Membuat file kontrol Debian..."
cat <<EOL > "$APP_NAME/DEBIAN/control"
Package: $APP_NAME
Version: $APP_VERSION
Section: utils
Priority: optional
Architecture: amd64
Depends: libgtk-3-0, libgconf-2-4
Maintainer: Your Name <your.email@example.com>
Description: $APP_DESCRIPTION
    A brief description of what the app does.
EOL

# Buat file Desktop Entry
echo "Membuat file Desktop Entry..."
cat <<EOL > "$APP_NAME/usr/share/applications/$APP_NAME.desktop"
[Desktop Entry]
Name=$APP_NAME
Exec=/usr/local/bin/$APP_NAME/$APP_NAME
Icon=/usr/share/icons/hicolor/512x512/apps/$APP_NAME.png
Type=Application
Categories=Utility;
EOL

# Tambahkan ikon
echo "Menambahkan ikon aplikasi..."
cp "$ICON_PATH" "$APP_NAME/usr/share/icons/hicolor/512x512/apps/$APP_NAME.png"

# Bangun paket .deb
echo "Membangun paket .deb..."
dpkg-deb --build "$APP_NAME"

# Selesai
echo "Paket $APP_NAME.deb telah berhasil dibuat."


sudo apt remove --purge -y $APP_NAME

sudo dpkg -i ./$APP_NAME.deb && rm -rf ./$APP_NAME.deb ./$APP_NAME ./$APP_NAME-linux-x64


