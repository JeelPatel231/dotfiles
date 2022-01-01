#!/usr/bin/env bash

sudo pacman -S git --noconfirm

# clone my repo so files gets placed
git clone https://github.com/jeelpatel231/dotfiles ~
rm -rf ~/.git

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
yes | makepkg -si
cd .. && rm -rf yay

# install i3 gaps, xorg
sudo pacman -S i3-gaps xorg sddm --noconfirm
yay -S i3status --noconfirm
sudo systemctl enable sddm.service

# install maim for screenshot and playerctl for working with media
sudo pacman -S playerctl maim --noconfirm

# install picom compositor
yay -S picom-ibhagwan-git --noconfirm

# install konsole
sudo pacman -S konsole --noconfirm

# install rofi app launcher and terminal
yay -S rofi ttf-menlo-powerline-git --noconfirm

# install oh-my-bash for theme
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"