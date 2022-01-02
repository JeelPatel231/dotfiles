#!/usr/bin/env bash

sed -i "s/#ParallelDownloads/ParallelDownloads/" /etc/pacman.conf

read -p "root : " root
read -p "boot : " boot

mkfs.ext4 /dev/$root
e2label /dev/$root root

read -p "first setup/linux only?  [y/n] : " bootcheck

if [[ $bootcheck == y ]]
then
echo "'y' is selected, formatting boot partition."
mkfs.fat -F32 /dev/$boot
else
echo "'not y, continuing without formatting boot partition.'"
fi

mount /dev/$root /mnt
mkdir -p /mnt/boot
mount /dev/$boot /mnt/boot

pacstrap /mnt base base-devel linux linux-firmware networkmanager linux-headers vim

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt bash -c "$(curl -fsSL https://raw.githubusercontent.com/JeelPatel231/dotfiles/master/scripts/chroot.sh)"