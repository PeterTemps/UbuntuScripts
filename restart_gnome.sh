#!/bin/bash

gsettings set org.gnome.desktop.interface enable-animations false
sudo sysctl -w net.core.wmem_max=8388608

# Restart XRDP service
echo "Restarting XRDP service..."
sudo systemctl restart xrdp

# Kill existing GNOME sessions
echo "Killing existing GNOME sessions..."
sudo pkill -9 -u $(whoami) gnome-session

# Restart GNOME desktop
echo "Restarting GNOME desktop..."
sudo systemctl restart gdm
