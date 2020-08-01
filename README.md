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
```

## KDE
```
sudo pacman -S plasma konsole dolphine code xdg-user-dirs
yay -S brave-beta-bin
xdg-user-dirs-update
sudo systemctl enable sddm
```
* Shortcut fix `mkdir ~/.local/share/kglobalaccel`

## i3
```
sudo pacman -S xorg-server xorg-xinit i3-gaps i3blocks i3lock i3status feh rxvt-unicode dmenu noto-fonts network-manager-applet pulseaudio pamixer ranger w3m
```
