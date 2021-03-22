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
lsblk -f
sudo vim /etc/fstab
UUID="{efi}" /boot vfat defaults 0 2
UUID="" /run/media/{username}/{drivename} ntfs{type} defaults 0 0
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
nm-connection-editor
import vpn
vpn settings:
	add dns servers 103.86.96.100, 103.86.99.100
connection settings:
	auto connect to vpn
	ignore ipv6
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
