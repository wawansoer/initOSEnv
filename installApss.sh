#!/bin/bash
if [ -x "$(command -v apt)" ]; then
    sudo apt install -y curl wget \
        flatpak \
        git \
        zsh \
        gnome-shell-extension-prefs \
        gnome-tweaks 
elif [ -x "$(command -v dnf)" ]; then
    sudo dnf install -y curl wget \
        flatpak \
        git \
        zsh \
        gnome-shell-extension-prefs \
        gnome-tweaks 
fi

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub \
    com.boxy_svg.BoxySVG \
    com.brave.Browser \
    com.github.PintaProject.Pinta \
    com.icons8.Lunacy \
    com.mattjakeman.ExtensionManager \
    io.github.vikdevelop.SaveDesktop \
    io.missioncenter.MissionCenter \
    net.devolutions.RDM \
    nl.hjdskes.gcolor3 \
    org.jaspstats.JASP
    
if [ -x "$(command -v apt)" ]; then
    sudo apt remove gnome-system-monitor -y
elif [ -x "$(command -v dnf)" ]; then
    sudo dnf remove gnome-system-monitor -y
fi
