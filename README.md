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

## DKE
```
sudo pacman -S plasma konsole dolphine code xdg-user-dirs
yay -S brave-bin
xdg-user-dirs-update
sudo systemctl enable sddm
```
