#!/bin/bash

# Update package list
sudo apt update

# Install required packages
sudo apt install -y software-properties-common

# Add PHP repository
sudo add-apt-repository -y ppa:ondrej/php

# Update package list again
sudo apt update

# Install PHP 8.2 and required extensions
sudo apt install -y php8.2-fpm php8.2-cli php8.2-curl \
    php8.2-mbstring php8.2-xml php8.2-zip php8.2-xdebug \
    php8.2-redis php8.2-pgsql php8.2-mysql php8.2-sqlite3   \
    php8.2-bcmath php8.2-imagick php8.2-soap php8.2-intl \
    php8.2-uuid php8.2-zip php8.2-gd php8.2-pdo php8.2-tokenizer \
    php8.2-fileinfo php8.2-dom php8.2-common

# Install Nginx
sudo apt install -y nginx

# Install Composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# Install Node.js and npm
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs

# Install Valet Linux dependencies
sudo apt install -y network-manager libnss3-tools jq xsel

# Install Valet Linux
composer global require cpriego/valet-linux

# Add Composer's global bin to PATH
echo 'export PATH="$PATH:$HOME/.config/composer/vendor/bin"' >> ~/.bashrc
source ~/.bashrc

# Install and configure Valet
valet install

echo "Installation complete. You may need to restart your terminal for all changes to take effect."