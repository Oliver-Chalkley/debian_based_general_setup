#!/bin/bash

# if ~/.fonts directory does not exist, create it
if [ ! -d ~/.fonts ]; then
  mkdir ~/.fonts
fi
# unzip the fonts to the ~/.fonts directory
unzip -o fonts.zip -d ~/.fonts

# update the font cache
fc-cache -f -v
