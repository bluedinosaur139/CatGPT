
#!/bin/bash

# Detect the system architecture
ARCH=$(uname -m)

# Check if the user is root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (use sudo)."
    exit
fi

# Function to create the desktop entry and launcher script
create_desktop_entry() {
    APP_NAME="CatGPT"
    DESKTOP_FILE="$HOME/.local/share/applications/catgpt.desktop"
    LAUNCHER_SCRIPT="$HOME/.local/bin/catgpt-launcher.sh"
    ICON_PATH="${HOME}/catgpt/CatGPT-linux-${ARCH}/resources/app/CatGPTIcon.png"
    DESKTOP_ICON="$(xdg-user-dir DESKTOP)/catgpt.desktop"


    # Create necessary directories
    mkdir -p ~/.local/share/applications
    mkdir -p ~/.local/bin

    # Fix permissions for ~/.local/share/applications and ~/.local/bin
    sudo chmod -R 755 ~/.local/share/applications
    sudo chmod -R 755 ~/.local/bin

    # Create the launcher script based on architecture
    echo "#!/bin/bash" > $LAUNCHER_SCRIPT
    if [ "$ARCH" == "x86_64" ]; then
        echo "/path/to/catgpt-x64" >> $LAUNCHER_SCRIPT
    elif [ "$ARCH" == "aarch64" ]; then
        echo "/path/to/catgpt-arm64" >> $LAUNCHER_SCRIPT
    else
        echo "Unsupported architecture: $ARCH" >> $LAUNCHER_SCRIPT
        exit 1
    fi

    # Make the launcher script executable
    chmod +x $LAUNCHER_SCRIPT

   # Create the .desktop file
cat <<EOF > $DESKTOP_FILE
[Desktop Entry]
Version=1.0
Name=$APP_NAME
Comment=Standalone ChatGPT App
Exec=$LAUNCHER_SCRIPT %U
Icon=${HOME}/catgpt/CatGPT-linux-${ARCH}/resources/app/CatGPTIcon.png
Terminal=false
Type=Application
Categories=Utility;
EOF

    # Fix permissions for the .desktop file
    sudo chmod 755 $DESKTOP_FILE

    # Copy the .desktop file to the desktop
    cp $DESKTOP_FILE ~/Desktop/catgpt.desktop

    # Fix permissions for the desktop icon
    chmod 755 ~/Desktop/catgpt.desktop

    # Optional: Update the desktop database (for some desktop environments)
    update-desktop-database ~/.local/share/applications/ 2>/dev/null

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
    else
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
    else
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
else
    echo "Unsupported distribution. Only Debian and Arch-based systems are supported."
    exit 1
fi

# Final message
echo "Installation script completed."
