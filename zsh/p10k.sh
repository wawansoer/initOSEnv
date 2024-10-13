#!/bin/bash

# Ensure script is run with sudo
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root or use sudo"
    exit
fi

# Clone Powerlevel10k theme
echo "Cloning Powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Set Powerlevel10k as the Zsh theme
echo "Setting Powerlevel10k as the Zsh theme..."
sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc

# Source the .zshrc file
echo "Sourcing .zshrc..."
source ~/.zshrc

# Prompt to run the configuration wizard
echo "To configure Powerlevel10k, please run: p10k configure"
echo "You may also want to install a Nerd Font for better appearance."

# Installation of Nerd Font
read -p "Do you want to download and install MesloLGS NF font? (y/n) " install_font

if [[ $install_font == "y" ]]; then
    echo "Downloading MesloLGS NF font..."
    mkdir -p ~/.fonts
    wget -O ~/.fonts/Meslo.zip https://github.com/romkatv/powerlevel10k-media/blob/master/Meslo.zip?raw=true
    unzip ~/.fonts/Meslo.zip -d ~/.fonts
    rm ~/.fonts/Meslo.zip

    echo "Updating font cache..."
    fc-cache -fv

    echo "Font installed. Please set your terminal to use 'MesloLGS NF' font."
else
    echo "Font installation skipped."
fi

echo "Installation complete! Please restart your terminal."
