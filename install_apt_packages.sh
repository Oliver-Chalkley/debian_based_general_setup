#!/bin/bash

# This script installs all apt packages
# I prefer it

# update and upgrade
sudo apt update -y
sudo apt upgrade -y

# install git etc
sudo apt install -y git curl wget
sudo apt install -y hub # this is the github cli
git config --global init.defaultBranch main
git config --global core.editor "vim"
git config --global user.email
git config --global user.name

# install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -fr lazygit*

# GNU Screen
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs # for coc.nvim
sudo apt-get install screen -y # terminal multiplexer
sudo apt install feh -y # lightweight image viewer
sudo apt install rsync -y # for syncing/transfering files
sudo apt install fzf -y # fuzzy finder
sudo apt install tree -y # tree view of directories
sudo apt install htop -y # CPU monitor
sudo apt install nvtop -y # NVIDIA GPU monitor
sudo apt install pigz -y # parallel gzip
sudo apt install exuberant-ctags -y # for vim tags
sudo apt install screenfetch -y #  display system inormation in pretty stdout
pip install terminaltexteffects -y # https://chrisbuilds.github.io/terminaltexteffects/showroom/

sudo apt install xsel -y # for clipboard
sudo apt install nmap -y # for network mapping
sudo apt install net-tools -y # for network tools

# install latex
#sudo apt install texlive-full -y

# dconf tools not installed by default
sudo add-apt-repository universe
sudo apt update -y
sudo apt install dconf-cli dconf-editor -y
