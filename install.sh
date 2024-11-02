#!/bin/bash

# Detect the system architecture
ARCH=$(uname -m)
echo "Detected architecture: $ARCH"

# Preserve the original user's home directory
USER_HOME=$(eval echo ~$SUDO_USER)
echo "User's home directory: $USER_HOME"

# Function to create the desktop entry and launcher script
create_desktop_entry() {
    echo "Creating desktop entry..."
    APP_NAME="CatGPT"
    DESKTOP_FILE="$USER_HOME/.local/share/applications/catgpt.desktop"
    LAUNCHER_SCRIPT="$USER_HOME/.local/bin/catgpt-launcher.sh"
    
    # Updated path for the icon
    ICON_PATH="${USER_HOME}/catgpt/catgpt/CatGPT-linux-x64/resources/resources/CatGPTIcon.png"
    DESKTOP_ICON="$(xdg-user-dir DESKTOP)/catgpt.desktop"

    # Create necessary directories as the user
    mkdir -p "$USER_HOME/.local/share/applications" || { echo "Failed to create applications directory"; exit 1; }
    mkdir -p "$USER_HOME/.local/bin" || { echo "Failed to create bin directory"; exit 1; }

    # Fix permissions for the user's local directories (no sudo needed)
    chmod -R 755 "$USER_HOME/.local/share/applications" || { echo "Failed to set permissions on applications directory"; exit 1; }
    chmod -R 755 "$USER_HOME/.local/bin" || { echo "Failed to set permissions on bin directory"; exit 1; }

    # Create the launcher script based on architecture
    echo "#!/bin/bash" > $LAUNCHER_SCRIPT
    if [ "$ARCH" == "x86_64" ]; then
        echo "${USER_HOME}/catgpt/catgpt/CatGPT-linux-x64/CatGPT" >> $LAUNCHER_SCRIPT
    elif [ "$ARCH" == "aarch64" ]; then
        echo "${USER_HOME}/catgpt/CatGPT-linux-arm64/CatGPT" >> $LAUNCHER_SCRIPT
    else
        echo "Unsupported architecture: $ARCH" >> $LAUNCHER_SCRIPT
        echo "Exiting due to unsupported architecture."
        exit 1
    fi

    # Make the launcher script executable
    chmod +x $LAUNCHER_SCRIPT || { echo "Failed to make launcher script executable"; exit 1; }

    # Suppress XDG warnings for Debian
    if [ -f /etc/debian_version ]; then
        export XDG_DATA_HOME="$USER_HOME/.local/share"
        export XDG_CONFIG_HOME="$USER_HOME/.config"
        export XDG_CACHE_HOME="$USER_HOME/.cache"
    fi

    # Create the .desktop file
    cat <<EOF > $DESKTOP_FILE
[Desktop Entry]
Version=1.0
Name=$APP_NAME
Comment=Standalone ChatGPT App
Exec=$LAUNCHER_SCRIPT %U
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Utility;
EOF

    # Verify if the file was created
    if [ -f "$DESKTOP_FILE" ]; then
        echo "Desktop file created: $DESKTOP_FILE"
    else
        echo "Failed to create the .desktop file."
        exit 1
    fi

    # Fix permissions for the .desktop file
    chmod 755 $DESKTOP_FILE || { echo "Failed to set permissions on .desktop file"; exit 1; }

    # Copy the .desktop file to the desktop
    cp $DESKTOP_FILE "$(xdg-user-dir DESKTOP)/catgpt.desktop" || { echo "Failed to copy .desktop file to desktop"; exit 1; }

    # Fix permissions for the desktop icon
    chmod 755 "$(xdg-user-dir DESKTOP)/catgpt.desktop" || { echo "Failed to set permissions on desktop icon"; exit 1; }

    # Optional: Update the desktop database (for some desktop environments)
    update-desktop-database "$USER_HOME/.local/share/applications/" 2>/dev/null

    echo "$APP_NAME desktop entry created and placed on the desktop."
}

# Function to install on Fedora-based systems
install_fedora() {
    echo "Detected Fedora-based system."
    
    echo "Installing nodejs and npm..."
    sudo dnf install -y nodejs npm || { echo "Failed to install nodejs and npm"; exit 1; }

    echo "Installing Electron and Electron Packager..."
    npm install electron --save-dev || { echo "Failed to install Electron"; exit 1; }
    npm install electron-packager --save-dev || { echo "Failed to install Electron Packager"; exit 1; }

    echo "Cloning the repository..."
    git clone https://github.com/bluedinosaur139/catgpt.git || { echo "Failed to clone repository"; exit 1; }

    cd catgpt || { echo "Failed to navigate to 'catgpt' directory."; exit 1; }

    echo "Fixing permissions for the repository..."
    sudo chown -R $USER:$USER ./ || { echo "Failed to change ownership of repository"; exit 1; }
    sudo chmod -R 755 ./  # Fix permissions

    echo "Installing dependencies..."
    npm install || { echo "Failed to install npm dependencies"; exit 1; }

    echo "Cleaning up previous builds..."
    rm -rf ./CatGPT-linux-x64 || { echo "Failed to remove previous builds"; }

    echo "Building the app..."
    npm run build || { echo "Build failed"; exit 1; }

    # Fix permissions on the build directory based on architecture
    if [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
        echo "Fixing permissions for ARM build..."
        sudo chown -R $USER:$USER ./CatGPT-linux-arm64 || { echo "Failed to change ownership of ARM build"; exit 1; }
        chmod -R 755 ./CatGPT-linux-arm64 || { echo "Failed to set permissions on ARM build"; exit 1; }
    elif [[ "$ARCH" == "x86_64" ]]; then
        echo "Fixing permissions for x64 build..."
        sudo chown -R $USER:$USER ./CatGPT-linux-x64 || { echo "Failed to change ownership of x64 build"; exit 1; }
        chmod -R 755 ./CatGPT-linux-x64 || { echo "Failed to set permissions on x64 build"; exit 1; }
    fi

    echo "CatGPT has been built and permissions fixed."

    # Call the function to create the desktop entry
    create_desktop_entry
}

# Check for the type of Linux distribution
if [ -f /etc/debian_version ]; then
    echo "Debian-based system detected."
    install_debian
elif [ -f /etc/arch-release ]; then
    echo "Arch-based system detected."
    install_arch
elif [ -f /etc/fedora-release ]; then
    echo "Fedora-based system detected."
    install_fedora
else
    echo "Unsupported distribution. Only Debian, Arch, and Fedora-based systems are supported."
    exit 1
fi

# Final message
echo "Installation script completed."
