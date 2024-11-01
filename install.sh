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
    
    # Updated path for the icon
    ICON_PATH="${USER_HOME}/catgpt/catgpt/CatGPT-linux-x64/resources/resources/CatGPTIcon.png"
    DESKTOP_ICON="$(xdg-user-dir DESKTOP)/catgpt.desktop"

    # Create necessary directories as the user
    mkdir -p "$USER_HOME/.local/share/applications"
    mkdir -p "$USER_HOME/.local/bin"

    # Fix permissions for the user's local directories (no sudo needed)
    chmod -R 755 "$USER_HOME/.local/share/applications"
    chmod -R 755 "$USER_HOME/.local/bin"

    # Create the launcher script based on architecture
    echo "#!/bin/bash" > $LAUNCHER_SCRIPT
    if [ "$ARCH" == "x86_64" ]; then
        echo "${USER_HOME}/catgpt/catgpt/CatGPT-linux-x64/CatGPT" >> $LAUNCHER_SCRIPT
    elif [ "$ARCH" == "aarch64" ]; then
        echo "${USER_HOME}/catgpt/CatGPT-linux-arm64/CatGPT" >> $LAUNCHER_SCRIPT
    else
        echo "Unsupported architecture: $ARCH" >> $LAUNCHER_SCRIPT
        exit 1
    fi

    # Make the launcher script executable
    chmod +x $LAUNCHER_SCRIPT

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
    chmod 755 $DESKTOP_FILE

    # Copy the .desktop file to the desktop
    cp $DESKTOP_FILE "$(xdg-user-dir DESKTOP)/catgpt.desktop"

    # Fix permissions for the desktop icon
    chmod 755 "$(xdg-user-dir DESKTOP)/catgpt.desktop"

    # Optional: Update the desktop database (for some desktop environments)
    update-desktop-database "$USER_HOME/.local/share/applications/" 2>/dev/null

    echo "$APP_NAME desktop entry created and placed on the desktop."
}

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
    git clone https://github.com/bluedinosaur139/catgpt.git

    cd catgpt || { echo "Failed to navigate to 'catgpt' directory."; exit 1; }

    echo "Fixing permissions for the repository..."
    sudo chown -R $USER:$USER ./
    sudo chmod -R 755 ./  # Fix permissions

    echo "Installing dependencies..."
    npm install

    echo "Cleaning up previous builds..."
    rm -rf ./CatGPT-linux-* || true  # Removing sudo for rm is safer

    echo "Building the app..."
    npm run build

    # Fix permissions on the build directory based on architecture
    if [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
        echo "Fixing permissions for ARM build..."
        sudo chown -R $USER:$USER ./CatGPT-linux-arm64  # Ownership fix
        chmod -R 755 ./CatGPT-linux-arm64
    elif [[ "$ARCH" == "x86_64" ]]; then
        echo "Fixing permissions for x64 build..."
        sudo chown -R $USER:$USER ./CatGPT-linux-x64  # Ownership fix
        chmod -R 755 ./CatGPT-linux-x64
    fi

    echo "CatGPT has been installed successfully."

    # Call the function to create the desktop entry
    create_desktop_entry
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
    git clone https://github.com/bluedinosaur139/catgpt.git

    cd catgpt || { echo "Failed to navigate to 'catgpt' directory."; exit 1; }

    echo "Fixing permissions for the repository..."
    sudo chown -R $USER:$USER ./
    sudo chmod -R 755 ./  # Fix permissions

    echo "Installing dependencies..."
    npm install

    echo "Cleaning up previous builds..."
    rm -rf ./CatGPT-linux-x64 || true  # Removing sudo for rm is safer

    echo "Building the app..."
    npm run build

    # Fix permissions on the build directory based on architecture
    if [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
        echo "Fixing permissions for ARM build..."
        sudo chown -R $USER:$USER ./CatGPT-linux-arm64  # Ownership fix
        chmod -R 755 ./CatGPT-linux-arm64
    elif [[ "$ARCH" == "x86_64" ]]; then
        echo "Fixing permissions for x64 build..."
        sudo chown -R $USER:$USER ./CatGPT-linux-x64  # Ownership fix
        chmod -R 755 ./CatGPT-linux-x64
    fi

    echo "CatGPT has been built and permissions fixed."

    # Call the function to create the desktop entry
    create_desktop_entry
}

# Function to install on Fedora-based systems
install_fedora() {
    echo "Detected Fedora-based system."
    echo "Installing nodejs and npm..."
    sudo dnf install -y nodejs npm

    echo "Installing Electron and Electron Packager..."
    npm install electron --save-dev
    npm install electron-packager --save-dev

    echo "Cloning the repository..."
    git clone https://github.com/bluedinosaur139/catgpt.git

    cd catgpt || { echo "Failed to navigate to 'catgpt' directory."; exit 1; }

    echo "Fixing permissions for the repository..."
    sudo chown -R $USER:$USER ./
    sudo chmod -R 755 ./  # Fix permissions

    echo "Installing dependencies..."
    npm install

    echo "Cleaning up previous builds..."
    rm -rf ./CatGPT-linux-x64 || true  # Removing sudo for rm is safer

    echo "Building the app..."
    npm run build

    # Fix permissions on the build directory based on architecture
    if [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
        echo "Fixing permissions for ARM build..."
        sudo chown -R $USER:$USER ./CatGPT-linux-arm64  # Ownership fix
        chmod -R 755 ./CatGPT-linux-arm64
    elif [[ "$ARCH" == "x86_64" ]]; then
        echo "Fixing permissions for x64 build..."
        sudo chown -R $USER:$USER ./CatGPT-linux-x64  # Ownership fix
        chmod -R 755 ./CatGPT-linux-x64
    fi

    echo "CatGPT has been built and permissions fixed."

    # Call the function to create the desktop entry
    create_desktop_entry
}

# Check for the type of Linux distribution
if [ -f /etc/debian_version ]; then
    install_debian
elif [ -f /etc/arch-release ]; then
    install_arch
elif [ -f /etc/fedora-release ]; then
    install_fedora
else
    echo "Unsupported distribution. Only Debian, Arch, and Fedora-based systems are supported."
    exit 1
fi

# Final message
echo "Installation script completed."
