#!/bin/bash

# initate conda
#conda init

# update conda
conda update --all -y

conda update -n base -c defaults conda -y

# install ipython
conda install -c anaconda ipython -y
# create ipython global config file
ipython profile create
# enable vi mode in ipython
sed -i "s/# c.TerminalInteractiveShell.editing_mode = 'emacs'/c.TerminalInteractiveShell.editing_mode = 'vi'/" ~/.ipython/profile_default/ipython_config.py
sed -i "s/# c.TerminalInteractiveShell.editor = 'vi'/c.TerminalInteractiveShell.editor = 'vim'/" ~/.ipython/profile_default/ipython_config.py

# jupyter 
conda install -c anaconda jupyter -y

# jupyter-ascending
pip install jupyter_ascending && \
python -m jupyter nbextension    install jupyter_ascending --sys-prefix --py && \
python -m jupyter nbextension     enable jupyter_ascending --sys-prefix --py && \
python -m jupyter serverextension enable jupyter_ascending --sys-prefix --py

jupyter nbextension install --py --sys-prefix jupyter_ascending
jupyter nbextension     enable jupyter_ascending --sys-prefix --py
jupyter serverextension enable jupyter_ascending --sys-prefix --py

