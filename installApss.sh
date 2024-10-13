#!/bin/bash
sudo apt install -y \
    flatpak \
    git \
    zsh \
    gnome-shell-extension-prefs
    gnome-tweaks \ 
    gnome-shell-extension-manager \
    chrome-gnome-shell \ 

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install com.boxy_svg.BoxySVG \
    com.brave.Browser \ 
    com.github.PintaProject.Pinta \
    com.icons8.Lunacy \
    com.mattjakeman.ExtensionManager \ 
    io.github.vikdevelop.SaveDesktop \
    io.missioncenter.MissionCenter \
    net.devolutions.RDM nl.hjdskes.gcolor3 \
    org.jaspstats.JASP \
    -y

sudo apt remove gnome-system-monitor -y