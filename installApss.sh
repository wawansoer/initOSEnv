#!/bin/bash
sudo apt install git zsh -y

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