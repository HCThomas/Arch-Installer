# Arch-Installer

## Start Installer
```
curl -L https://git.io/JJuf2 > install
bash install
```
## After Reboot
```
curl -L https://git.io/JJw8r > install
bash install
rm install
```

## KDE
```
sudo pacman -S plasma konsole dolphine code xdg-user-dirs
yay -S brave-bin
xdg-user-dirs-update
sudo systemctl enable sddm
```
* Shortcut fix `mkdir ~/.local/share/kglobalaccel`

## i3
```
sudo pacman -S xorg-server xorg-xinit i3-gaps i3blocks i3lock feh rxvt-unicode urxvt-perls dmenu noto-fonts pulseaudio pamixer ranger w3m
```
