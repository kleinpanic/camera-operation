#!/usr/bin/env bash

# Function to confirm uninstallation
confirm_uninstall() {
    echo "Are you sure you want to uninstall the camera program?"
    echo "This will remove the virtual environment and all installed files."
    read -p "Type 'yes' to proceed: " confirmation

    if [ "$confirmation" != "yes" ]; then
        echo "Uninstallation canceled."
        exit 0
    fi
}

# Function for local uninstallation
local_uninstall() {
    VENV_DIR="$DIR/../venv"
    echo "Starting local uninstallation..."

    # Remove the virtual environment directory
    if [ -d "$VENV_DIR" ]; then
        echo "Removing virtual environment..."
        rm -rf "$VENV_DIR"
    fi

    # echo "Removing source code..."
    # rm -rf "$DIR/../src/camera-command.py"

    echo "Local uninstallation complete."
}

# Function for system-wide uninstallation
system_wide_uninstall() {
    echo "Starting system-wide uninstallation..."
    VENV_DIR="/lib/python-venvs/camera-op"
    SRC_DIR="/usr/local/share/camera-op/src"

    # Remove the system-wide virtual environment
    if [ -d "$VENV_DIR" ]; then
        echo "Removing system-wide virtual environment..."
        sudo rm -rf "$VENV_DIR"
    fi

    # Remove the source code directory
    if [ -d "$SRC_DIR" ]; then
        echo "Removing source code..."
        sudo rm -rf "$SRC_DIR"
    fi

    if [ -f "/usr/local/bin/camera-op" ]; then
        echo "Removing camera-op executable..."
        sudo rm /usr/local/bin/camera-op
    fi

    echo "System-wide uninstallation complete."
}

# Main uninstallation logic
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
confirm_uninstall

if [ -f "/usr/local/bin/camera-op" ]; then
    system_wide_uninstall
else
    local_uninstall
fi

