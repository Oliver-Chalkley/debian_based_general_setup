#!/bin/bash

# This script installs everything neccessary for a basic coding enviornment as I prefer it
# - GNU Screen
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
sudo apt update
sudo apt upgrade

# GNU Screen
sudo apt-get install screen

# enable vim shortcuts in the terminal (requires changes to bashrc (terminal) and inputrc (anything that uses readline())
echo ' ' >> ~/.bashrc
echo '# enable vim shortcuts in the terminal ' >> ~/.bashrc
echo 'set -o vi' >> ~/.bashrc

echo ' ' >> ~/.inputrc
echo '# enable vim shortcuts ' >> ~/.inputrc
echo 'set editing-mode vi ' >> ~/.inputrc
echo 'set keymap vi ' >> ~/.inputrc

# ipython stopped using readline so to get vi shortcuts in ipython you need to dp the following
if [[ ! -f ~/.ipython/profile_default/ipython_config.py ]] # if ipython configuration file does not exist then run the command to create it
then
    ipython profile create
fi
sed -i "s/# c.TerminalInteractiveShell.editing_mode = 'emacs'/c.TerminalInteractiveShell.editing_mode = 'vi'/"

# VIM
# Uninstall mini version and install fully featured version
sudo apt remove --assume-yes vim-tiny # DO WE NEED SUDO IN AWS INSTANCE?????
# tidy up
sudo apt autoremove
sudo apt update
# install full version of vim
sudo apt install --assume-yes vim
# create vimrc
touch ~/.vimrc
# Turn on syntax highlighting
echo '" Turn on syntax highlighting' >> ~/.vimrc
echo 'syntax on' >> ~/.vimrc

# VIM PLUGINS
# PATHOGEN
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
# add code to vimrc
echo '" Add pathogen' >> ~/.vimrc
echo "execute pathogen#infect()" >> ~/.vimrc
echo "syntax on" >> ~/.vimrc
echo "filetype plugin indent on" >> ~/.vimrc

# vim-airline
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
echo " " >> ~/.vimrc 
echo '" Change configuration of vim-airline' >> ~/.vimrc 
echo "let g:airline#extensions#tabline#enabled = 1" >> ~/.vimrc

# vim-rainbow
git clone https://github.com/frazrepo/vim-rainbow ~/.vim/bundle/vim-rainbow
echo " " >> ~/.vimrc
echo '" change configuration of vim-rainbow' >> ~/.vimrc
echo "let g:rainbow_active = 1" >> ~/.vimrc

# vim-ale
git clone https://github.com/dense-analysis/ale.git ~/.vim/bundle/ale

# gruvbox
git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox
echo " " >> ~/.vimrc
echo '" change configuration of vim-gruvbox' >> ~/.vimrc
echo "autocmd vimenter * ++nested colorscheme gruvbox" >> ~/.vimrc
echo 'set background=dark " Setting dark mode' >> ~/.vimrc

# Kite
# goto https://github.com/kiteco/vim-plugin

# ANNACONDA
wget -P /tmp https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh && bash /tmp/Anaconda3-2021.05-Linux-x86_64.sh -b 
export PATH=~/anaconda3/bin:$PATH
conda init
source ~/.bashrc
conda update --all

