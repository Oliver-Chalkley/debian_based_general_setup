#! /bin/bash

# This script sets up vim plugin manager and installs plugins

# Manger:
# - ViM-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# create .vimrc
ln dotfiles/vimrc ~/.vimrc

# run plug install
vim -c 'PlugInstall'
vim -c 'CocInstall coc-json coc-tsserver coc-clangd coc-cmake coc-copilot coc-docker coc-explorer coc-floaterm coc-fzf-preview coc-git coc-highlight coc-jedi coc-markdownlint coc-lists coc-nav coc-prettier coc-pydocstring coc-pyright coc-sh coc-snippets coc-spell-checker coc-sql coc-sqlfluff coc-swagger coc-toml coc-xml coc-yaml'
vim -c 'Copilot setup'
