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
# cp -r $CWD ~/Documents/gh/personal

# copy scripts
# cp -r ~/Documents/gh/personal/personal-arch-quickstart/shared/scripts ~/Documents

# install yay
if ! command -v yay &> /dev/null; then
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd .. && rm -rf yay
fi

# install nerd fonts
yay -S nerd-fonts

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

# file manager
yay -S lf

# power profiles
yay -S power-profiles-daemon

# ima install it anyways
yay -S alacritty
yay -S neovim
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
