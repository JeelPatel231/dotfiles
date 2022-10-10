#!/usr/bin/env bash

sudo pacman -S git --noconfirm

# clone my repo so files gets placed
git init
git remote add origin https://github.com/jeelpatel231/dotfiles
git pull origin master
rm -rf .git scripts

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
yes | makepkg -si
cd .. && rm -rf yay

# install i3 gaps, xorg
sudo pacman -S i3-gaps xorg --noconfirm
yay -S i3status --noconfirm

# install flameshot for screenshot,
# playerctl for working with media,
# feh for wallpaper  ----> ADD YOUR WALLPAPERS TO ~/wallpapers/ DIRECTORY <-----
# xclip to copy main content to clipboard
sudo pacman -S playerctl flameshot feh xclip --noconfirm

# laptop specific addons
sudo pacman -S light
#add user to video group so light command works
sudo usermod -aG video $USER

# install picom compositor
yay -S picom-ibhagwan-git --noconfirm

# install konsole
sudo pacman -S konsole --noconfirm

# install rofi app launcher and terminal
yay -S rofi ttf-menlo-powerline-git --noconfirm

# install oh-my-bash for theme
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
