# Arch-Installer

## Start Installer
```
curl -sL https://git.io/JJuf2 | bash
```

## Install AUR yay
```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd
```

## User Dir
```
sudo pacman -S xdg-user-dirs
xdg-user-dirs-update
```
