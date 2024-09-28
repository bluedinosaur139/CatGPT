#!/bin/bash

# Detect the system architecture
ARCH=$(uname -m)

# Check if the user is root
if [ "$EUID" -ne 0 ]
then 
    echo "Please run as root (use sudo)."
    exit
fi

# Function to install on Debian-based systems
install_debian() {
    echo "Detected Debian-based system."
    echo "Updating package lists..."
    sudo apt update

    echo "Installing nodejs and npm..."
    sudo apt install -y npm nodejs

    echo "Installing Electron..."
    npm install electron

    echo "Cloning the repository..."
    git clone https://github.com/bluedinosaur139/catgpt.git ~/catgpt

    cd ~/catgpt || { echo "Failed to navigate to 'catgpt' directory."; exit 1; }

    echo "Installing dependencies..."
    npm install

    echo "Building the app..."
    npm run build

    echo "Moving build to desired directory..."
    mv CatGPT-linux-x64 ~/CatGPTApp

    echo "CatGPT has been installed successfully at ~/CatGPTApp."
}

# Function to install on Arch-based systems
install_arch() {
    echo "Detected Arch-based system."
    echo "Installing nodejs and npm..."
    sudo pacman -S --noconfirm nodejs npm

    echo "Installing Electron and Electron Packager..."
    npm install electron --save-dev
    npm install electron-packager --save-dev

    echo "Cloning the repository..."
    git clone https://github.com/bluedinosaur139/catgpt.git ~/catgpt

    cd ~/catgpt || { echo "Failed to navigate to 'catgpt' directory."; exit 1; }

    echo "Installing dependencies..."
    npm install

    echo "Building the app..."
    npm run build

    echo "Moving build to desired directory..."
    mv CatGPT-linux-x64 ~/CatGPTApp

    echo "CatGPT has been installed successfully at ~/CatGPTApp."
}

# Check for the type of Linux distribution
if [ -f /etc/debian_version ]; then
    install_debian
elif [ -f /etc/arch-release ]; then
    install_arch
else
    echo "Unsupported distribution. Only Debian and Arch-based systems are supported."
    exit 1
fi

# Final message
echo "Installation script completed."
