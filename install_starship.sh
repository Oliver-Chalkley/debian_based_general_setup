#!/bin/bash
# Description: Install starship

# Install starship
#curl -fsSL https://starship.rs/install.sh | bash
mkdir -p ~/.config
cp -r dotfiles/starship.toml ~/.config
