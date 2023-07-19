#!/bin/bash

# This script installs everything neccessary for a basic coding enviornment as
# I prefer it
# - XCFE Desktop environment
# - GNU Screen
# - Vim9
# - Vim9 Plugins
# - Setup my person windows management shortcuts (vim-esque)
# - VIM shortcuts in terminal and readline() apps
# - Anaconda (NEED TO CHANGE THIS TO MINICONDA)

# update and upgrade
sudo apt update -y
sudo apt upgrade -y

# install XCFE
sudo apt install xfce4 xfce4-goodies -y

# install git etc
sudo apt install -y git curl wget
sudo apt install -y hub # this is the github cli
git config --global init.defaultBranch main


# install vim9
./install_vim.sh

# install vim plugins
./vim_plugins.sh

# GNU Screen
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
sudo apt-get install screen -y
sudo apt install feh -y
sudo apt install rsync -y
sudo apt install fzf -y
sudo apt install tree -y

# dconf tools not installed by default
sudo add-apt-repository universe
sudo apt update -y
sudo apt install dconf-cli dconf-editor -y

# setup my windows management shortcuts
dconf load /org/gnome/desktop/wm/keybindings/ < dconf_shortcuts_backup

# update .bashrc
sed -i "/^HISTSIZE=/c\HISTSIZE=-1" ~/.bashrc
sed -i "/^HISTFILESIZE=/c\HISTFILESIZE=-1" ~/.bashrc
# link dotfiles
./link_dotfiles.sh

# install NodeJS so that autocomplete works
#curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
#sudo apt-get install -y nodejs

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
./install_anaconda.sh

echo "You must restart your computer for changes to take effect."
sudo reboot

# run post installaion script
./post_startup_script.sh
