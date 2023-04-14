#!/bin/bash

# This script installs everything neccessary for a basic coding enviornment as
# I prefer it
# - GNU Screen
# - i3 Tiling manager
# - Setup my person windows management shortcuts (vim-esque)
# - VIM shortcuts in terminal and readline() apps
# - Full version of VIM
#      - Pathogen
#      - vim-airline
#      - vim-rainbo
#      - ALE
#      - gruvbox
#      - kite
# - Anaconda

# update and upgrade
sudo apt update -y
sudo apt upgrade -y

# GNU Screen
sudo apt-get install screen -y

# i3 Tiling manager
sudo apt install i3-wm i3status suckless-tools i3lock

# dconf tools not install by default
sudo add-apt-repository universe
sudo apt update
sudo apt install dconf-cli dconf-editor

# setup my windows management shortcuts
dconf load /org/gnome/desktop/wm/keybindings/ < dconf_shortcuts_backup

# overwrite .bashrc
rm ~/.bashrc
ln dotfiles/bashrc ~/.bashrc

# overwrite .bash_aliases
rm ~/.bash_aliases
ln dotfiles/bash_aliases ~/.bash_aliases

# overwrite .inputrc
rm ~/.inputrc
ln dotfiles/inputrc ~/.inputrc

# overwrite .profile
rm ~/.profile
ln dotfiles/profile ~/.profile

# overwrite ~/.ssh/config
rm ~/.ssh/config
ln dotfiles/ssh_config ~/.ssh/config

# overwrite ~/.i3/config
rm ~/.i3/config
ln dotfiles/i3_config ~/.i3/config

# VIM
# Uninstall mini version and install fully featured version
sudo apt remove --assume-yes vim-tiny # DO WE NEED SUDO IN AWS INSTANCE?????
# tidy up
sudo apt autoremove -y
sudo apt update -y
# install full version of vim
sudo apt install --assume-yes vim=8.1.1719 # we want a minimum version here so upgrade after
sudo apt update -y
sudo apt upgrade -y

# install NodeJS so that autocomplete works
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

# create .vimrc
ln dotfiles/vimrc ~/.vimrc

# VIM PLUGINS
# PATHOGEN
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# vim-airline
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline

# vim-rainbow
git clone https://github.com/frazrepo/vim-rainbow ~/.vim/bundle/vim-rainbow

# vim-ale
git clone https://github.com/dense-analysis/ale.git ~/.vim/bundle/ale

# gruvbox
git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox

# Kite
# goto https://github.com/kiteco/vim-plugin

# Conquer of Completion (coc) for autocomplete
cd ~/.vim/bundle
git clone https://github.com/neoclide/coc.nvim.git

# vimspector for debugging
cd ~/.vim/bundle
git clone https://github.com/puremourning/vimspector

# ANNACONDA
wget -P /tmp https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh && bash /tmp/Anaconda3-2021.05-Linux-x86_64.sh -b 
export PATH=~/anaconda3/bin:$PATH
conda init
source ~/.bashrc
conda update --all

conda update -n base -c defaults conda
