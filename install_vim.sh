#!/bin/bash

# Remove old vim installs
sudo apt-get remove vim vim-runtime gvim vim-tiny \
vim-common vim-gui-common vim-nox gvim

# install vim-gtk deps
sudo apt-get build-dep vim-gtk

# install some more deps
sudo apt-get install build-essential \
libncurses5-dev libgtk-3-dev libatk1.0-dev \
libcairo2-dev libx11-dev libxpm-dev libxt-dev python2.7-dev \
python3-dev ruby-dev libperl-dev \
lua5.2 liblua5.2-0 liblua5.2-dev

# NOTE: if you don't have it already installed, get latest git
#sudo add-apt-repository ppa:git-core/ppa
#sudo apt-get update
#sudo apt-get install git

cd && \
mkdir vimtemp && cd vimtemp && \
git clone https://github.com/vim/vim.git && \
cd vim

make clean
make distclean

./configure \
--with-features=huge \
--enable-cscope \
--enable-multibyte \
--enable-perlinterp=dynamic \
--enable-rubyinterp=dynamic \
--enable-luainterp=dynamic \
--enable-python3interp \
--with-python3-config-dir=/usr/lib/python3.8/config-3.8-x86_64-linux-gnu \
--with-python3-command=python3 \
--enable-gui=auto \
--enable-gtk3-check \
--enable-gtk2-check \
--enable-gnome-check \
--with-x \
--disable-netbeans \
--with-compiledby="pirafrank <dev@fpira.com>" \
--enable-largefile \
--prefix=/usr/local \
--enable-terminal \
--enable-fontset \
--enable-fail-if-missing

make -j4 VIMRUNTIMEDIR=/usr/local/share/vim/vim82
sudo make install

sudo update-alternatives --install /usr/bin/editor editor  /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim editor  /usr/local/bin/vim
update-alternatives --list editor # if you want to check your alternatives
sudo update-alternatives --install /usr/bin/vi vi  /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim
update-alternatives --list vi # if you want to check your alternatives
sudo update-alternatives --install /usr/bin/vim vim  /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim
update-alternatives --list vim # if you want to check your alternatives

# all done!
