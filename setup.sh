#!/bin/bash
clear
echo -e "\e[31mStarting with the installation process...\e[0m"
sleep 5
echo -e "\e[31mInstalling exiftool...\e[0m"
sudo apt install -y exiftool
echo -e "\e[1;32m Installed! \e[0m"
echo -e "\e[31mInstalling Sysvbanner...\e[0m"
sudo apt install -y sysvbanner
echo -e "\e[1;32m Installed! \e[0m"
echo -e "\e[31mInstalling binutils...\e[0m"
sudo apt install -y binutils
echo -e "\e[1;32m Installed! \e[0m"
echo -e "\e[1;32m Giving necessary permissions... \e[0m"
chmod +x staticot.sh
echo -e "\e[1;32m The setup is now complete! \e[0m"
