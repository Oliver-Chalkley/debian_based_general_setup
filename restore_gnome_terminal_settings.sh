#! /bin/bash

# This script is inspired from https://askubuntu.com/questions/967517/how-to-backup-gnome-terminal-emulator-settings

# This resets all the terminal settings - it probably isn't needed but I left it commented just in case
#  dconf reset -f /org/gnome/terminal/

dconf load /org/gnome/terminal/ < gnome_terminal_settings_backup.txt.bk
