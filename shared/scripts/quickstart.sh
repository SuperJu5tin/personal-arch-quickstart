#!/bin/bash
# This script is for setting up a personal Arch Linux environment quickly.
# It installs necessary packages, configures the system, and sets up personal scripts.

# reposition everything
mkdir ~/Pictures
mkdir ~/Videos
mkdir -p ~/Documents/gh/personal
# cp -r ../../../personal-arch-quickstart ~/Documents/gh/personal

# copy scripts
cp -r ~/Documents/gh/personal/personal-arch-quickstart/shared/scripts ~/Documents

# install yay
if ! command -v yay &> /dev/null; then
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
ffmpeg

# install zsh
yay -S zsh

# install dependencies for bar
yay -S acpi
yay -S udisks2
yay -S libnotify
yay -S bc

# install ohmyzsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# autosuggesions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search

echo "
# Terminal autocomplete fix
autoload -Uz compinit && compinit

plugins=(
    git
    docker
    asdf
    nvm
    npm
    zsh-autosuggestions
    zsh-completions
    zsh-history-substring-search
    zsh-syntax-highlighting
)
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/init-nvm.sh
export ANDROID_HOME=~/Android/Sdk
export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH

" >> ~/.zshrc
