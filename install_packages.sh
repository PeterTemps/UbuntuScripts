#!/bin/bash

# Update the package list
sudo apt update

# Install the required packages
sudo apt install -y mc build-essential aria2 wget curl zsh git \
    python3 python3-pip python3-venv virtualenv \
    cmake make automake gdb \
    nodejs npm \
    default-jdk \
    ruby rails \
    net-tools nmap tcpdump \
    rsync openssh-server ftp \
    vim nano emacs \
    tmux screen \
    htop iotop \
    docker.io docker-compose \
    virtualbox vagrant \
    ufw \
    gpg cryptsetup

# Install Oh My Zsh
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    chsh -s $(which zsh)
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Verify installation (optional)
echo "Installation complete. Verifying installation of packages..."

for package in mc build-essential aria2 wget curl zsh git \
    python3 python3-pip python3-venv virtualenv \
    cmake make automake gdb \
    nodejs npm \
    default-jdk \
    ruby rails \
    net-tools nmap tcpdump \
    rsync openssh-server ftp \
    vim nano emacs \
    tmux screen \
    htop iotop \
    docker.io docker-compose \
    virtualbox vagrant \
    ufw \
    gpg cryptsetup; 
do
    if dpkg -l | grep -q $package; then
        echo "$package is installed successfully."
    else
        echo "Failed to install $package."
    fi
done

echo "All specified packages have been processed."

