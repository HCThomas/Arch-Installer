# Arch-Installer

## Start Installer
```
curl -L https://git.io/JqJHf > install && bash install
```

## Usefull commands
### Wifi
```
iwctl
	device list
	station device scan
	station device get-networks
	station device connect SSID
```
### Network Manager
```
nmtui
```
### Bluetooth
```
bluetoothctl
```
### Printers
```
pacman cups ghostscript
yay epson-inkjet-printer-escpr
systemctl enable cups
localhost:631/admin
```
### Mounting drives
```
blkid
sudo vim /etc/fstab
UUID="" /run/media/{username}/{drivename} ntfs{type} defaults 0 0
lsblk
sudo mount /dev/sd?? /run/media/{username}/{drivename}
```
### Nordvpn
```
yay nordvpn-bin
systemctl enable nordvpnd
gpasswd -a $(whoami) nordvpn
```
or
```
pacman networkmanager-openvpn network-manager-applet
```
### RGB
```
pacman liquidctl
yay ckb-next
systemctl enable ckb-next-daemon
```
### Other Programs
```
pacman keepassxc code steam discord qbittorrent calibre thunderbird virtualbox
yay hakuneko-desktop fsearch-git
```
