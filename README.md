# Arch-Installer

## Start Installer
```
curl -L https://git.io/JtMqP > install
bash install
```
## After Reboot
```
curl -L https://git.io/JtMqX > install
bash install
rm install
```

## Wifi
### Before Install
```
iwctl
	device list
	station device scan
	station device get-networks
	station device connect SSID
```
### Network Manager
```
nmcli d wifi list
nmcli d wifi connect SSID password password
```

## Bluetooth
```
bluetoothctl
```

## Cups printers
localhost:631/admin

## Mounting drives
```
chown holden /run/media/{username}

blkid
sudo vim /etc/fstab
UUID="" /run/media/{username}/{drivename} ntfs{type} defaults 0 0

lsblk
sudo mount /dev/sd?? /run/media/{username}/{drivename}
sudo mount ntfs-3g /dev/sd?? /run/media/{username}/{drivename}
```
