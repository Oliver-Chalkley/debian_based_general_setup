#!/bin/bash

# Set the projects path - change this to your desired directory
projects_path="$HOME/projects"

# Create the directory if it doesn't exist
mkdir -p ${projects_path}

# Update and install necessary dependencies
sudo apt-get update
sudo apt-get install -y python3-dev libncurses5-dev libncursesw5-dev build-essential git

# Clone the Vim repository
if [ ! -d "${projects_path}/vim" ]; then
  git clone https://github.com/vim/vim.git ${projects_path}/vim
else
  echo "Vim repository already cloned in ${projects_path}/vim"
fi

# Navigate to the src directory of Vim
cd ${projects_path}/vim

# Clean any previous builds
make distclean

# Configure Vim with Python3 support
./configure --with-features=huge \
            --enable-multibyte \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(python3-config --configdir) \
            --prefix=/usr/local

# Build and install Vim
make
sudo make install

# Verify the installation
vim --version | grep +python3

echo "Vim9 with Python3 support has been successfully installed."

