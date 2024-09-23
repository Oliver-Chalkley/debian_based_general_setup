# setup my windows management shortcuts
dconf load /org/gnome/desktop/wm/keybindings/ < dconf_shortcuts_backup

# update .bashrc
sed -i "/^HISTSIZE=/c\HISTSIZE=-1" ~/.bashrc
sed -i "/^HISTFILESIZE=/c\HISTFILESIZE=-1" ~/.bashrc

# link dotfiles
./link_dotfiles.sh

# install bins
./install_bins.sh
