# Suckless configs
sudo make -C ~/.config/suckless/slstatus install
sudo make -C ~/.config/suckless/st install
sudo make -C ~/.config/suckless/dmenu install
sudo make -C ~/.config/suckless/dwm install

cp ~/.config/suckless/slstatus/config.h ~/gh-repos/personal/personal-arch-quickstart/suckless/slstatus
cp ~/.config/suckless/st/config.h ~/gh-repos/personal/personal-arch-quickstart/suckless/st
cp ~/.config/suckless/dmenu/config.h ~/gh-repos/personal/personal-arch-quickstart/suckless/dmenu
cp ~/.config/suckless/dwm/config.h ~/gh-repos/personal/personal-arch-quickstart/suckless/dwm-patch

# Scripts
cp -r ~/Scripts/* ~/gh-repos/personal/personal-arch-quickstart/Scripts/

git -C ~/gh-repos/personal/personal-arch-quickstart add .
git -C ~/gh-repos/personal/personal-arch-quickstart commit -am "updates to configs"
git -C ~/gh-repos/personal/personal-arch-quickstart push
