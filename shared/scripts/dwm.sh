# install xorg
pacman -S xorg-server xorg-xinit xorg-xrandr xorg-xsetroot

# xinit file
touch ~/.xinitrc
echo "feh --bg-scale ~/Pictures/background.jpg
picom &
exec slstatus &
exec dwm
" > ~/.xinitrc

# move to the gh-repos
mkdir -p ~/gh-repos/personal
cd ~/gh-repos/personal
git clone https://github.com/SuperJu5tin/personal-arch-quickstart.git

# install dwm, dmenu, st, slstatus
mkdir -p ~/.config/suckless
cd ~/.config/suckless
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/st
git clone https://git.suckless.org/slstatus

# apply patches
cd ~/.config/suckless/dwm
curl -O https://dwm.suckless.org/patches/pertag/dwm-pertag-20200914-61bb8b2.diff
curl -O https://dwm.suckless.org/patches/statuscolors/dwm-statuscolors-20220322-bece862.diff
curl -O https://dwm.suckless.org/patches/vanitygaps/dwm-vanitygaps-20190508-6.2.diff

patch -p1 < dwm-pertag-20200914-61bb8b2.diff
patch -p1 < dwm-statuscolors-20220322-bece862.diff
patch -p1 < dwm-vanitygaps-20190508-6.2.diff

cd ~/.config/suckless/st
curl -O https://st.suckless.org/patches/alpha/st-alpha-20240814-a0274bc.diff
patch -p1 < st-alpha-20240814-a0274bc.diff

# copy configs
cp ~/gh-repos/personal/personal-arch-quickstart/suckless/dwm-patch ~/.config/suckless/dwm/config.h
cp ~/gh-repos/personal/personal-arch-quickstart/suckless/dmenu ~/.config/suckless/dmenu/config.h
cp ~/gh-repos/personal/personal-arch-quickstart/suckless/st ~/.config/suckless/st/config.h
cp ~/gh-repos/personal/personal-arch-quickstart/suckless/slstatus ~/.config/suckless/slstatus/config.h

cp ~/gh-repos/personal/personal-arch-quickstart/sync.sh ~/.config/suckless/sync.sh
