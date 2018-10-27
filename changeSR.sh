#!/bin/bash
# 180113 Cheongyo Bahk
# one file solution to change screen resolution of ubuntu on hyper-v

echo "return 1 for macbook / 2 for PC"
# EDIT HERE
read __flag__
# recommended values:
#	1) for Macbook remote control
#	     1440 x 900
#	2) for direct hyper-v host PC
#	     1920 x 1080
#	   maximum possible screen resolution
#	     1920 x 1080

__valid__=1
case ${__flag__} in
    1) __width__="1440"; __height__="900"
       ;;
    2) __width__="1920"; __height__="1080"
       ;;
    *) echo "...Something going wrong... ABORT!"
       __valid__=0
       ;;
esac


if [ ${__valid__} = 1 ]
then

    sudo sed -i "s@GRUB_CMDLINE_LINUX_DEFAULT=.*@GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash video=hyperv_fb:${__width__}x${__height__}\"@" /etc/default/grub

    sed -i "s@<width>.*@<width>${__width__}</width>@" ~/.config/monitors.xml

    sed -i "s@<height>.*@<height>${__height__}</height>@" ~/.config/monitors.xml

    sudo update-grub

    echo -e "\n\n...Change screen resolution: ${__width__}x${__height__}"
    echo "Restart to apply change" 
fi
