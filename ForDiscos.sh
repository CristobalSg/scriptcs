#! /bin/bash

lsblk
# Formateamos partes
mkfs.vfat -F32 /dev/sda1 # boot; 521M 
mkfs.ext4 /dev/sda3      # raiz; 30G
mkfs.ext4 /dev/sda4      # home; 370G
mkswap /dev/sda2         # swap; 8G
swapon
# montamos los sda
mount /dev/sda3 /mnt
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
mkdir /mnt/home
mount /dev/sda4 /mnt/home

pacman -Sy archlinux-keyring

pacstrap /mnt base linux linux-firmware nano grub networkmanager dhcpcd efibootmgr neovim

genfstab -U /mnt >> /mnt/etc/fstab

pacstrap /mnt netctl wpa_supplicant

arch-chroot /mnt
# zona horaria
ln -sf /usr/share/zoneinfo/America/Santiago /etc/localtime
# editamos el archivo
nvim /etc/locale.gen # Buscar en_US.UTF-8 UTF-8 y es_ES.UTF-8 UTF-8
locale-gen
systemctl enable NetworkManager 

hwclock --systohc
echo "LANG=es_CL.UTF-8" > /etc/locale.conf 
echo "KEYMAP=es" > /etc/vconsole.conf 
echo "cscolchones" > /etc/hostname 

# grub
grub-install --target=x86_64-efi --efi-directory=/boot 
grub-mkconfig -o /boot/grub/grub.cfg