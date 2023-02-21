#! /bin/bash

# This script sets up vim plugin manager and installs plugins

# Manger:
# - ViM-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
