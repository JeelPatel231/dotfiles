#!/usr/bin/env bash

# enable parallel downloading
sed -i "s/#ParallelDownloads/ParallelDownloads/" /etc/pacman.conf

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

locale-gen

echo "archlinux" > /etc/hostname
echo -e "127.0.0.1 localhost\n::1 localhost\n127.0.1.1 archlinux" >> /etc/hosts

echo "root password setup :"
passwd

bootctl install --esp-path=/boot

mkdir -p /boot/loader/entries
echo -e "default  arch.conf\ntimeout 4" >> /boot/loader/loader.conf
echo -e 'title "Arch Linux"\nlinux /vmlinuz-linux\ninitrd /initramfs-linux.img\noptions root="LABEL=root" rw' >> /boot/loader/entries/arch.conf

# enable services
systemctl enable NetworkManager
systemctl enable sddm

echo "enter username : "
read username
useradd -m -g users -G wheel -s /bin/bash $username
echo "enter user $username password: "
passwd $username


# allow wheel to use sudo
sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/" /etc/sudoers


# optional i3 setup with sddm
echo "optional next script to setup i3 and sddm"
read optional
if [[ $optional == y ]]
then
echo "'y' is selected, continuing."
su -c 'bash -c $(curl -fsSL https://raw.githubusercontent.com/JeelPatel231/dotfiles/master/scripts/start.sh)' - $username
else
echo "'not y, setup finished.'"
fi