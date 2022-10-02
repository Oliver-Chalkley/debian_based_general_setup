#! /bin/bash

# env variables
laptop_resolution=3840x2160
work_screen_resolution=2560x1440

read -p "Please select one of the following screen resolutions:
	[1]: Laptop resoltion, ${laptop_resolution}
	[2]: Work screen resolution, ${work_screen_resolution}"  -n 1 -r
echo    # (optional) move to a new line
if [  $REPLY -eq 1 ]
then 
	echo "Changing work resolution to laptop resolution."
	sudo sed -i "s/${work_screen_resolution}/${laptop_resolution}/g" /etc/default/grub
elif [  $REPLY -eq 2 ]
then
	echo "Changing laptop resolution to work resolution."
	sudo sed -i "s/${laptop_resolution}/${work_screen_resolution}/g" /etc/default/grub
else
    echo "Incorrect selection, exiting script."
    exit 0
fi

sudo update-grub 

sudo reboot
