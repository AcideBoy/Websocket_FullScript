#!/bin/bash

# Remove old installer
rm -rf install

# Update system
sudo apt update && sudo apt upgrade -y

# Download SlowDNS installer
wget https://github.com/khaledagn/SlowDNS/raw/main/install

# Make it executable
chmod 777 install

# Run installer
./install --start
