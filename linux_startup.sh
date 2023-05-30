#!/bin/bash

# This script installs everything neccessary for a basic coding enviornment as
# I prefer it
# - GNU Screen
# - Vim9
# - Vim9 Plugins
# - Setup my person windows management shortcuts (vim-esque)
# - VIM shortcuts in terminal and readline() apps
# - Anaconda (NEED TO CHANGE THIS TO MINICONDA)

# update and upgrade
sudo apt update -y
sudo apt upgrade -y

# install vim9
./install_vim.sh

# install vim plugins
./install_vim_plugins.sh

# GNU Screen
sudo apt-get install screen -y
sudo apt install feh -y

# dconf tools not install by default
sudo add-apt-repository universe
sudo apt update
sudo apt install dconf-cli dconf-editor -y

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

# install NodeJS so that autocomplete works
#curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
#sudo apt-get install -y nodejs

# create .vimrc
ln dotfiles/vimrc ~/.vimrc

# VIM PLUGINS
# PATHOGEN
#mkdir -p ~/.vim/autoload ~/.vim/bundle && \
#curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
#
## vim-airline
#git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
#
## vim-rainbow
#git clone https://github.com/frazrepo/vim-rainbow ~/.vim/bundle/vim-rainbow
#
## vim-ale
#git clone https://github.com/dense-analysis/ale.git ~/.vim/bundle/ale
#
## gruvbox
#git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox
#
## Kite
## goto https://github.com/kiteco/vim-plugin
#
## Conquer of Completion (coc) for autocomplete
#cd ~/.vim/bundle
#git clone https://github.com/neoclide/coc.nvim.git
#
## vimspector for debugging
#cd ~/.vim/bundle
#git clone https://github.com/puremourning/vimspector

# ANNACONDA
wget -P /tmp https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh && bash /tmp/Anaconda3-2021.05-Linux-x86_64.sh -b 
export PATH=~/anaconda3/bin:$PATH
conda init
source ~/.bashrc
conda update --all

conda update -n base -c defaults conda

echo "Please restart your terminal to complete the installation"
