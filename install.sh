
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
    # Define variables
    APP_NAME="CatGPT"
    DESKTOP_FILE="$HOME/.local/share/applications/catgpt.desktop"
    LAUNCHER_SCRIPT="$HOME/.local/bin/catgpt-launcher.sh"
    ICON_PATH="${HOME}/catgpt/CatGPT-linux-${ARCH}/resources/app/CatGPTIcon.png"
    DESKTOP_ICON="$HOME/Desktop/catgpt.desktop"

    # Create necessary directories
    echo "Creating necessary directories..."
    mkdir -p ~/.local/share/applications
    mkdir -p ~/.local/bin

    # Fix permissions for directories
    sudo chmod -R 755 ~/.local/share/applications
    sudo chmod -R 755 ~/.local/bin

    # Create the launcher script based on architecture
    echo "Creating the launcher script..."
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
    echo "Launcher script created and made executable."

    # Create the .desktop file
    echo "Creating the .desktop file..."
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
    sudo chmod 755 $DESKTOP_FILE
    echo ".desktop file permissions fixed."

    # Copy the .desktop file to the desktop
    echo "Copying .desktop file to desktop..."
    cp $DESKTOP_FILE ~/Desktop/catgpt.desktop

    # Fix permissions for the desktop icon
    chmod 755 ~/Desktop/catgpt.desktop
    echo "Desktop icon permissions fixed."

    # Optional: Update the desktop database (for some desktop environments)
    update-desktop-database ~/.local/share/applications/ 2>/dev/null
    echo "Desktop database updated."

    # Final message
    echo "$APP_NAME desktop entry created and placed on the desktop."
}

