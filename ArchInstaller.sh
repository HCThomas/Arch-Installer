#!/bin/bash

########## Choose Profile ##########
## Profile Require
# hostname,user,password(" ")
# device(/dev/sd*)
# grubRemovable (1-yes,0-no)
# virtualBox (1-yes,0-no)
# nvidia (1-yes,0-no)
# cpu (1-Intel,0-AMD)
##

echo -en "1.\tVirtualBox\n2.\tDesktop\n0.\tOther\nEnter Profile: "
read profile
if [ "$profile" == "" ]; then echo "Profile can't be empty"; exit 1; fi

### VirtualBox ###
if [ $profile -eq 1 ]; then
hostname="ArchVB"
user="holden"
password="0"
device="/dev/sda"
grubRemovable=0
virtualBox=1
nvidia=0
cpu=1
fi

### Desktop ###
if [ $profile -eq 2 ]; then
hostname="HT-ArchDesktop"
user="holden"
grubRemovable=1
virtualBox=0
nvidia=1
cpu=1

echo -n "Password: "
read -s password
if [ "$password" == "" ]; then echo "Password can't be empty"; exit 1; fi
echo -en "\nRepeat Password: "
read -s password2
if [ "$password" != "$password2" ]; then echo "Passwords did not match"; exit 1; fi

lsblk -p
echo -en "\nEnter installation disk: "
read device
if [ "$device" == "" ]; then echo "Device can't be empty"; exit 1; fi
fi

### Other ###
if [ $profile -eq 0 ]; then
virtualBox=0

echo -n "Enter hostname: "
read hostname
if [ "$hostname" == "" ]; then echo "Hostname can't be empty"; exit 1; fi

echo -n "Enter username: "
read user
if [ "$user" == "" ]; then echo "User can't be empty"; exit 1; fi

echo -n "Password: "
read -s password
if [ "$password" == "" ]; then echo "Password can't be empty"; exit 1; fi
echo -en "\nRepeat Password: "
read -s password2
if [ "$password" != "$password2" ]; then echo "Passwords did not match"; exit 1; fi

lsblk -p
echo -en "\nEnter installation disk: "
read device
if [ "$device" == "" ]; then echo "Device can't be empty"; exit 1; fi

echo -en "1.\tYes\n0.\tNo\nGrub removable installation: "
read grubRemovable
if [ "$grubRemovable" == "" ]; then echo "Grub Removable can't be empty"; exit 1; fi

echo -en "1.\tYes\n0.\tNo\nInstall Nvidia Drivers: "
read nvidia
if [ "$nvidia" == "" ]; then echo "Nvidia can't be empty"; exit 1; fi

echo -en "1.\tIntel\n0.\tAMD\nIntel or AMD cpu: "
read cpu
if [ "$cpu" == "" ]; then echo "CPU can't be empty"; exit 1; fi
fi


########## Start Install ##########
timedatectl set-ntp true

### Setup the disk and partitions ###
echo -e "g\n  n\n\n\n+260M\nt\n1\n  n\n\n\n+8G\nt\n\n19\n  n\n\n\n\n  w\n" | fdisk $device

part_boot="${device}1"
part_swap="${device}2"
part_linux="${device}3"

mkfs.fat -F 32 $part_boot
mkfs.ext4 $part_linux

mkswap $part_swap
swapon $part_swap

mount $part_linux /mnt
mkdir /mnt/boot
mount $part_boot /mnt/boot

### Install the basic system ###
pacstrap /mnt base base-devel linux linux-firmware man-db man-pages texinfo networkmanager gvim git grub efibootmgr
if [ $virtualBox -eq 1 ]; then pacstrap /mnt virtualbox-guest-utils; fi
if [ $nvidia -eq 1 ]; then pacstrap /mnt nvidia nvidia-settings; fi
if [ $cpu -eq 1 ]; then pacstrap /mnt intel-ucode; else pacstrap /mnt amd-ucode; fi

### Configure the basic system ###
genfstab -U /mnt >> /etc/fstab

arch-chroot /mnt ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
arch-chroot /mnt hwclock --systohc

sed -i "177 s/^##*//" /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
echo LANG=en_US.UTF-8 >> /mnt/etc/locale.conf

echo $hostname >> /mnt/etc/hostname
echo -e "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\t${hostname}.localdomain\t${hostname}" >> /mnt/etc/hosts

arch-chroot /mnt systemctl enable NetworkManager
if [ $virtualBox -eq 1 ]; then arch-chroot /mnt systemctl enable vboxservice; fi

### Grub boot loader ###
if [ $grubRemovable -eq 1 ]; then
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=boot --removable
else
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=boot --bootloader-id=GRUB
fi

arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

### Users ###
arch-chroot /mnt useradd -m -G wheel,audio,disk,input,kvm,optical,scanner,storage,video $user
sed -i "82 s/^##*//" /mnt/etc/sudoers
echo -e "${password}\n${password}" | arch-chroot /mnt passwd
echo -e "${password}\n${password}" | arch-chroot /mnt passwd $user

########## Extra Config ##########
sed -i "33 s/^##*//;92,93 s/^##*//;37i ILoveCandy" /mnt/etc/pacman.conf
arch-chroot /mnt pacman -Syu

sed -i "s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/" /mnt/etc/default/grub
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

echo "reboot"
