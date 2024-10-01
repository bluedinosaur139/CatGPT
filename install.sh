#!/bin/bash

# Detect the system architecture
ARCH=$(uname -m)

# Preserve the original user's home directory
USER_HOME=$(eval echo ~$SUDO_USER)

# Function to create the desktop entry and launcher script
create_desktop_entry() {
    APP_NAME="CatGPT"
    DESKTOP_FILE="$USER_HOME/.local/share/applications/catgpt.desktop"
    LAUNCHER_SCRIPT="$USER_HOME/.local/bin/catgpt-launcher.sh"
    ICON_PATH="${USER_HOME}/catgpt/CatGPT-linux-${ARCH}/resources/app/CatGPTIcon.png"

    # Create necessary directories as the user
    mkdir -p "$USER_HOME/.local/share/applications" "$USER_HOME/.local/bin"

    # Create the launcher script based on architecture
    echo "#!/bin/bash" > $LAUNCHER_SCRIPT
    echo "${USER_HOME}/catgpt/CatGPT-linux-${ARCH}/CatGPT" >> $LAUNCHER_SCRIPT

    # Make the launcher script executable
    chmod +x $LAUNCHER_SCRIPT

    # Create the .desktop file
    cat <<EOF > $DESKTOP_FILE
[Desktop Entry]
Version=1.0
Name=$APP_NAME
Comment=Standalone ChatGPT App
Exec=$LAUNCHER_SCRIPT %U
Icon=${ICON_PATH}
Terminal=false
Type=Application
Categories=Utility;
EOF

    # Fix permissions for the .desktop file
    chmod 755 $DESKTOP_FILE

    # Optional: Update the desktop database
    update-desktop-database "$USER_HOME/.local/share/applications/" 2>/dev/null

    echo "$APP_NAME desktop entry created."
}

# Function to install on Debian-based systems
install_debian() {
    echo "Detected Debian-based system."
    sudo apt update
    sudo apt install -y npm nodejs
    npm install electron
    git clone https://github.com/bluedinosaur139/catgpt.git

    cd catgpt || { echo "Failed to navigate to 'catgpt' directory."; exit 1; }
    sudo chown -R $USER:$USER ./
    sudo chmod -R 755 ./

    npm install
    rm -rf ./CatGPT-linux-* || true
    npm run build

    # Fix permissions on the build directory
    if [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
        sudo chown -R $USER:$USER ./CatGPT-linux-arm64
        chmod -R 755 ./CatGPT-linux-arm64
    else
        sudo chown -R $USER:$USER ./CatGPT-linux-x64
        chmod -R 755 ./CatGPT-linux-x64
    fi

    echo "CatGPT has been installed successfully."
    create_desktop_entry
}

# Function to install on Arch-based systems
install_arch() {
    echo "Detected Arch-based system."
    sudo pacman -S --noconfirm nodejs npm
    npm install electron --save-dev
    npm install electron-packager --save-dev
    git clone https://github.com/bluedinosaur139/catgpt.git

    cd catgpt || { echo "Failed to navigate to 'catgpt' directory."; exit 1; }
    sudo chown -R $USER:$USER ./
    sudo chmod -R 755 ./

    npm install
    rm -rf ./CatGPT-linux-x64 || true
    npm run build

    # Fix permissions on the build directory
    if [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
        sudo chown -R $USER:$USER ./CatGPT-linux-arm64
        chmod -R 755 ./CatGPT-linux-arm64
    else
        sudo chown -R $USER:$USER ./CatGPT-linux-x64
        chmod -R 755 ./CatGPT-linux-x64
    fi

    echo "CatGPT has been built and permissions fixed."
    create_desktop_entry
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
