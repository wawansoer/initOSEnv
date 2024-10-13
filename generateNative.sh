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

# Jika membuat aplikasi Gmail, gunakan User-Agent untuk menghindari masalah keamanan
if [[ "$APP_NAME" == "Gmail" ]]; then
    echo "Membuat aplikasi Gmail dari $APP_URL..."
    nativefier --name "$APP_NAME" --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36" "$APP_URL"
else
    # Buat aplikasi menggunakan Nativefier
    echo "Membuat aplikasi $APP_NAME dari $APP_URL..."
    nativefier --name "$APP_NAME" "$APP_URL"
fi

# Buat struktur folder untuk paket Debian
echo "Membuat struktur folder untuk paket Debian..."
mkdir -p "$APP_NAME/DEBIAN"
mkdir -p "$APP_NAME/usr/local/bin"
mkdir -p "$APP_NAME/usr/share/applications"
mkdir -p "$APP_NAME/usr/share/icons/hicolor/512x512/apps"

# Salin aplikasi ke dalam struktur paket
echo "Menyalin aplikasi ke dalam struktur paket..."
cp -r "$APP_NAME-linux-x64/"* "$APP_NAME/usr/local/bin/"

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
Exec=/usr/local/bin/$APP_NAME
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
