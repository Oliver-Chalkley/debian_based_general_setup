#! /bin/bash

# This script is inspired from https://askubuntu.com/questions/967517/how-to-backup-gnome-terminal-emulator-settings

dconf dump /org/gnome/terminal/ > gnome_terminal_settings_backup.txt.bk
