#!/bin/bash
# This script creates links from the home directory to any desired dotfiles in ~/dotfiles
#
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

# create .vimrc
ln dotfiles/vimrc ~/.vimrc

# overwrite .gitconfig
rm ~/.gitconfig
ln dotfiles/gitconfig ~/.gitconfig
