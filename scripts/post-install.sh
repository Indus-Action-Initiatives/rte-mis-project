#!/bin/bash

# Check if running inside Lando
if [ -n "$LANDO_MOUNT" ]; then
    echo "Running inside a Lando container. Skipping this script."
    exit 0
fi

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install npm if not installed
if command_exists npm; then
    echo "npm is already installed. Skipping npm installation."
else
    echo "npm is not installed. Installing npm..."
    if command_exists apt-get; then
        sudo apt-get update
        sudo apt-get install -y npm
    elif command_exists yum; then
        sudo yum install -y npm
    elif command_exists brew; then
        brew install npm
    else
        echo "Package manager not supported. Please install npm manually."
        exit 1
    fi
fi

# Install gulp if not installed
if command_exists gulp; then
    echo "gulp is already installed. Skipping gulp installation."
else
    echo "gulp is not installed. Installing gulp..."
    npm install --global gulp-cli
fi

# Execute gulp in the rte-mis-gin module
echo "Executing gulp in the rte-mis-gin module..."
cd docroot/profiles/contrib/rte-mis/modules/rte_mis_gin || exit
npm install
gulp scss

echo "Gulp task in rte-mis-gin module completed successfully."
