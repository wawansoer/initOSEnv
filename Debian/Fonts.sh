sudo apt install -y fonts-firacode fonts-jetbrains-mono fonts-hack-ttf \
    fonts-adf-accanthis fonts-ubuntu fonts-dejavu-core fonts-roboto \
    fonts-inconsolata fonts-droid-fallback fonts-noto-mono fonts-freefont-otf \
    fonts-agave fonts-ocr-a  

sudo apt install fontconfig
cd ~
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
mkdir -p .local/share/fonts
unzip Meslo.zip -d .local/share/fonts
cd .local/share/fonts
rm *Windows*
cd ~
rm Meslo.zip
fc-cache -fv
