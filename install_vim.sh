#!/bin/bash

projects_path=${HOME}/projects
echo "projects path: ${projects_path}"

sudo apt install git -y
sudo apt install make -y
sudo apt install clang -y
sudo apt install libtool-bin -y
# Add X windows clipboard support (also needed for GUI):
sudo apt install libxt-dev -y
# Add GUI support:
sudo apt install libgtk-3-dev -y
# Add Python 3 support:
sudo apt install libpython3-dev -y
sed -i "s/#CONF_OPT_PYTHON3 = --enable-python3interp/CONF_OPT_PYTHON3 = --enable-python3interp/" ${projects_path}/vim/src/Makefile

# Build Vim
# git clone
cd ${projects_path}
git clone https://github.com/vim/vim.git
cd ${projects_path}/vim/src
echo "Should be in vim/src: $(pwd)"
make config
make

# Run tests to check there are no problems:
make test

# Install Vim in /usr/local:
sudo make install
