#!/bin/bash

# update and install EPEL
sudo dnf check-update
sudo dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

# install Remi
sudo dnf install https://rpms.remirepo.net/fedora/remi-release-40.rpm -y
sudo dnf module reset php -y
sudo dnf module install php:remi-8.2 -y

# install PHP and Extensions 
sudo dnf install php php-cli php-zip wget unzip php-process php-mbstring php-mcrypt php-xml php-sqlite3 php-mysql php-pgsql php-pecl-redis -y

# install Nginx and PHP-FPM
sudo dnf install nginx php-fpm -y
sudo systemctl enable --now nginx php-fpm
sudo systemctl status nginx php-fpm

# set up PHP-FPM config
sudo cp /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.bak
sudo cp ./www.conf /etc/php-fpm.d/www.conf

sudo systemctl restart php-fpm
sudo nginx -t
sudo systemctl reload nginx

# install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '9b9bff7bc0c5b155b7eae0e6c13db73b07f7c57cd5c8b2b42c1ee095eea10b4c2d1b3e7e4f4aa1076e65f5ac0c9712e7c') === false) { echo 'Installer corrupt'; unlink('composer-setup.php'); exit(1); }"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
composer --version

# add composer bin to PATH
echo "export PATH=\"\$PATH:~/.config/composer/vendor/bin\"" >> ~/.bashrc


# install Valet 
sudo dnf install nss-tools jq xsel
sudo sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
composer global require cpriego/valet-linux
valet install

