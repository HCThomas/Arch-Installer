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
nmtui
```

## DualBoot Clock Change
```
sudo timedatectl set-local-rtc true --adjust-system-clock
```

## Bluetooth
```
bluetoothctl
```

## Cups printers
```
localhost:631/admin
```

## Mounting drives
```
blkid
sudo vim /etc/fstab
UUID="" /run/media/{username}/{drivename} ntfs{type} defaults 0 0

lsblk
sudo mount /dev/sd?? /run/media/{username}/{drivename}
```
