#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update

# Install Zsh
echo "Installing Zsh..."
sudo apt install -y zsh curl

# Check Zsh version
echo "Checking Zsh version..."
zsh --version

# Change default shell to Zsh
echo "Changing default shell to Zsh..."
chsh -s $(which zsh)
sudo chsh -s $(which zsh)
# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Change Zsh theme
echo "Changing Zsh theme to agnoster..."
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc

# Install plugins
echo "Installing Zsh plugins..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Add plugins to .zshrc
echo "Adding plugins to .zshrc..."
sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting)/' ~/.zshrc

# Source the .zshrc file
echo "Sourcing .zshrc..."
source ~/.zshrc

echo "Installation complete! Please log out and log back in to start using Zsh."
