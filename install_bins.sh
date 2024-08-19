#! /bin/bash

# Install binaries

# if bin directory exists then throw error
if [ -d $HOME/bin ]; then
    echo "bin directory already exists"
    exit 1
fi

cd $HOME
git clone git@github.com-personal:Oliver-Chalkley/bin.git 
cd bin
chmod +x *
./install_bins.sh
