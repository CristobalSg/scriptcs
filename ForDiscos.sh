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