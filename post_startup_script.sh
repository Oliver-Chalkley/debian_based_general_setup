#!/bin/bash

# install ipython
conda install -c anaconda ipython
# create ipython global config file
ipython profile create
# enable vi mode in ipython
sed -i "s/# c.TerminalInteractiveShell.editing_mode = 'emacs'/c.TerminalInteractiveShell.editing_mode = 'vi'/" ~/.ipython/profile_default/ipython_config.py

