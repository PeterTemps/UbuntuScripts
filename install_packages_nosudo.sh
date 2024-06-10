#!/bin/bash

# Update the package list
apt update
apt upgrade -y

# Install the required packages
apt install mc build-essential aria2 wget curl zsh git \
    python3 python3-pip python3-venv virtualenv \
    cmake make automake gdb \
    libtcmalloc-minimal4 \
    git-lfs \
    mc \
    wormhole \
    gpg cryptsetup -y

wget -qO- cli.runpod.net | bash

for package in mc build-essential aria2 wget curl zsh git \
    python3 python3-pip python3-venv virtualenv \
    cmake make automake gdb \
    git-lfs \
    mc \
    wormhole \
    gpg cryptsetup; 
do
    if dpkg -l | grep -q $package; then
        echo "$package is installed successfully."
    else
        echo "Failed to install $package."
    fi
done

echo "All specified packages have been processed."

