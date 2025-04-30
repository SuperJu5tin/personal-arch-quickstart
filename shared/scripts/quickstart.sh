#!/bin/bash
# This script is for setting up a personal Arch Linux environment quickly.
# It installs necessary packages, configures the system, and sets up personal scripts.

# variables
CWD=$(pwd)

# reposition everything
mkdir ~/Pictures
mkdir ~/Videos
mkdir ~/Downloads
mkdir -p ~/Documents/gh/personal
mkdir ~/Documents/gh/school
mkdir ~/Documents/gh/work
cp -r $CWD ~/Documents/gh/personal

# copy scripts
# cp -r ~/Documents/gh/personal/personal-arch-quickstart/shared/scripts ~/Documents

# install yay
if ! command -v yay &> /dev/null; then
    makepkg -si
    cd .. && rm -rf yay
fi

# install nerd fonts
yay -S nerd-fonts

# install ly tui greeter
yay -S ly

sudo systemctl enable ly.service
sudo systemctl start ly.service

echo "\n[sessions]\ndefault_session=dwm" | sudo tee -a /etc/ly/config.ini

# background
yay -S feh
mkdir ~/Pictures
cp ~/Documents/gh/personal/personal-arch-quickstart/shared/background.jpg ~/Pictures
feh --bg-scale ~/Pictures/background.jpg

# transparent effects
yay -S picom

# install brightnessctl
yay -S brightnessctl

# install nvm
yay -S nvm

# videos
yay -S ffmpeg

# dashboard
yay -S btop

# notification
yay -S notify-send

# ima install it anyways
yay -S discord
yay -S spotify
yay -S chromium
yay -S google-chrome

# install zsh
yay -S zsh


# install ohmyzsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
