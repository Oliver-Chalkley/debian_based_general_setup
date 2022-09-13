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
sudo apt update -y
sudo apt upgrade -y

# GNU Screen
sudo apt-get install screen -y

# enable vim shortcuts in the terminal (requires changes to bashrc (terminal) and inputrc (anything that uses readline())
echo ' ' >> ~/.bashrc
echo '# enable vim shortcuts in the terminal ' >> ~/.bashrc
echo 'set -o vi' >> ~/.bashrc

echo ' ' >> ~/.inputrc
echo '# enable vim shortcuts ' >> ~/.inputrc
echo 'set editing-mode vi ' >> ~/.inputrc
echo 'set keymap vi ' >> ~/.inputrc

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
curl -fsSL https://deb.nodesource.com/setup_14.14 | sudo -E bash -
sudo apt-get install -y nodejs
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

# add coc configuration
cat ~/.vimrc coc_settings_template.txt > ~/.vimrc
# ANNACONDA
wget -P /tmp https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh && bash /tmp/Anaconda3-2021.05-Linux-x86_64.sh -b 
export PATH=~/anaconda3/bin:$PATH
conda init
source ~/.bashrc
conda update --all

