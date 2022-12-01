#! /bin/bash

# env variables
laptop_resolution=3840x2160
home_screen_resolution=1920x1080
work_screen_resolution=2560x1440

read -p "Please select the current screen resolution:
	[1]: Laptop resolution, ${laptop_resolution}
	[2]: Home screen resolution, ${home_screen_resolution}
	[3]: Work screen resolution, ${work_screen_resolution}"  -n 1 -r
echo    # (optional) move to a new line
if [  $REPLY -eq 1 ]
then 
	current_screen_resolution=${laptop_resolution}
elif [  $REPLY -eq 2 ]
then
	current_screen_resolution=${home_screen_resolution}
elif [  $REPLY -eq 3 ]
then
	current_screen_resolution=${work_screen_resolution}
else
    echo "Incorrect selection, exiting script."
    exit 0
fi
read -p "Please select one of the following screen resolutions to change to:
	[1]: Laptop resolution, ${laptop_resolution}
	[2]: Home Screen resolution, ${home_screen_resolution}
	[3]: Work screen resolution, ${work_screen_resolution}"  -n 1 -r
echo    # (optional) move to a new line
if [  $REPLY -eq 1 ]
then 
	echo "Changing resolution to laptop resolution."
	sudo sed -i "s/${current_screen_resolution}/${laptop_resolution}/g" /etc/default/grub
elif [  $REPLY -eq 2 ]
then
	echo "Changing resolution to home screen resolution."
	sudo sed -i "s/${current_screen_resolution}/${home_screen_resolution}/g" /etc/default/grub
elif [  $REPLY -eq 3 ]
then
	echo "Changing resolution to work resolution."
	sudo sed -i "s/${current_screen_resolution}/${work_screen_resolution}/g" /etc/default/grub
else
    echo "Incorrect selection, exiting script."
    exit 0
fi

sudo update-grub 

sudo reboot
