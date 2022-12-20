

root
setup-alpnie
us
us
eth0
dhcpcd
no
proxy - none

openssh
sda
sys
y
reboot

root
apk update
apk add nano
nano /etc/apk/repositories
# uncomment all
apk update

setup-xorg-base

apk add sed attr dialog dialog-doc bash bash-doc bash-completion grep grep-doc \
util-linux util-linux-doc pciutils usbutils binutils findutils readline \
man-pages lsof lsof-doc less less-doc nano nano-doc curl curl-doc \
coreutils coreutils-doc


export PAGER=less

apk add terminus-font ttf-inconsolata ttf-dejavu font-misc-cyrillic font-mutt-misc \
font-screen-cyrillic font-winitzki-cyrillic font-cronyx-cyrillic terminus-font \
font-sony-misc font-daewoo-misc font-jis-misc font-isas-misc

mkdir -p /etc/skel
nano /etc/skel/.Xresources

Xft.antialias: 0
Xft.rgba:      rgb
Xft.autohint:  0
Xft.hinting:   1
Xft.hintstyle: hintslight

apk add alsa-utils alsa-utils-doc alsa-lib alsaconf

rc-service alsa start
rc-update add alsa

nano /root/.cshrc

unsetenv DISPLAY || true
HISTCONTROL=ignoreboth

cp /root/.cshrc /root/.profile

nano /etc/apk/repositories

http://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/main
http://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/community
http://dl-cdn.alpinelinux.org/alpine/edge/main
http://dl-cdn.alpinelinux.org/alpine/edge/community
http://dl-cdn.alpinelinux.org/alpine/edge/testing

apk update

apk add xfce4
apk add thunar-volman
apk add faenza-icon-theme
rc-service dbus start
rc-update add dbus
rc-service udev start
rc-update add udev
apk add accountsservice ttf-cantarell librsvg gnome-icon-theme adwaita-icon-theme lightdm lightdm-gtk-greeter lightdm-openrc
rc-update add lightdm
apk add polkit consolekit2 xterm
apk add firefox

reboot

--------------------------------------------------

apk add xf86-input-synaptics alsa-utils alsa-plugins volumeicon
apk add pavucontrol pulseaudio pulseaudio-alsa pulseaudio-equalizer pulseaudio-jack pulsemixer pamixer pulseview
apk add xdg-user-dirs xdg-utils polkit gvfs gvfs-afc gvfs-mtp gvfs-smb acpid avahi cronie
# acpid avahi-daemon cronie
rc-service acpid start
rc-service avahi-daemon start
rc-service cronie start
rc-update add acpid
rc-update add avahi-daemon

apk add ark xarchiver file-roller
apk add unzip zip p7zip
apk add ttf-liberation ttf-dejavu terminus-font fontforge
apk add breeze breeze-grub breeze-icons faenza-icon-theme adwaita-icon-theme

--------------------------------------------------

apk add libuser

touch /etc/login.defs
mkdir -p /etc/default/
touch /etc/default/useradd
mkdir -p /etc/skel/
touch /etc/skel/.logout

nano /etc/skel/.cshrc

set autologout = 30
set prompt = "\$ "
set ignoreeof

cp /etc/skel/.cshrc /etc/skel/.profile

adduser -D -k /etc/skel -h /home/mikl -s /bin/bash mikl

adduser -D -h /home/mikl -s /bin/bash mikl

echo "mikl:1234" | chpasswd

for u in $(ls /home); do for g in disk usb cdrw ping kvm lp floppy audio cdrom dialout video netdev games users wheel; do addgroup $u $g; done;done

disk lp floppy audio cdrom dialout ping tape video netdev kvm games cdrw apache usb users

disk:x:6:root,adm Only if need usage vith virtual machines and access to other partitions over new disks for
lp:x:7:lp IF will need to use printing services and printers management
floppy:x:11:root Backguard compatible group, use only if need access to external special devices
audio:x:18: Need for audio listening and management of sound volumes as normal user
cdrom:x:19: For access to disck writers and mounting DVD, BR or CD rom disk as normal user
dialout:x:20:root Need for dial private connections and use of modems as normal users
ping:x:21:root Need to make ping test to ip addresses
tape:x:26:root Need have into this if plan to use special devices for backup.. rarelly in no servers
video:x:27:root For usage of cameras, mor thant one GPU special features, as normal user
netdev:x:28: For network connections management as normal user
kvm:x:34:kvm Only if as normal user will manage graphically virtual machines.. rarelly on no servers
games:x:35: Need if you want to play games also specially need if will share score between users
cdrw:x:80: To write RW-DVD, RW-BR or RW-CD disk on a disk writing device
apache:x:81: Need if you will perfom development as normal user and want to publish locally on web server
usb:x:85: Need to access to special usb devices, deprecated group
users:x:100:games If you plan to used common files for all users, mandatory as desktop usage

lchsh

# lchsh mikl

# chown <YourUserName> /home/<YourUserName> && chmod 700 /home/<YourUsername>
# or
# chown <YourUserName> /home/<YourUserName> && chmod 750 /home/<YourUsername>

--------------------------------------------------

echo "shortname" > /etc/hostname

nano /etc/hosts

nano /etc/resolv.conf

nameserver 8.8.8.8
nameserver 8.8.4.4

Enabling IPv6 (Optional)
modprobe ipv6
echo "ipv6" >> /etc/modules

nano /etc/network/interfaces

apk add networkmanager networkmanager-bash-completion networkmanager-cli networkmanager-qt network-manager-applet
# plasma-nm for Plasma integration and applet
# network-manager-applet for a GTK system tray applet

rc-service networkmanager start
adduser <YourUsername> plugdev

nano /etc/NetworkManager/NetworkManager.conf

[main] 
dhcp=internal
plugins=ifupdown,keyfile

[ifupdown]
managed=true

[device]
wifi.scan-rand-mac-address=yes
wifi.backend=wpa_supplicant

Now you need to stop conflicting services:
# rc-service networking stop
# rc-service wpa_supplicant stop
Now restart NetworkManager:
# rc-service networkmanager restart

rc-update add networkmanager

rc-service iwd start
rc-service networkmanager restart

# rc-update del networking boot
# rc-update del wpa_supplicant boot

--------------------------------------------------

apk add iptables
apk add ip6tables
apk add iptables-doc

rc-update add iptables
/etc/init.d/iptables save
# lbu ci

 rc-update add ip6tables
/etc/init.d/ip6tables save
# lbu ci

apk add iputils iproute2

--------------------------------------------------

apk add tzdata musl-locales musl-locales-lang
cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime
echo "Europe/Moscow" >  /etc/timezone
nano /etc/profile.d/locale.sh

export TZ=Europe/Moscow
export CHARSET=ru_RU.UTF-8
export LANG=ru_RU.UTF-8
export LANGUAGE=ru_RU.UTF-8
export LC_ALL=ru_RU.UTF-8

apk add terminus-font kbd-bkeymaps kbd
wget -O ru-utf.map.gz https://aur.archlinux.org/cgit/aur.git/plain/ru-utf.map.gz?h=kbd-ru-keymaps

sed -i 's/unicode="NO"/unicode="YES"/' /etc/rc.conf
nano /etc/conf.d/consolefont

rc-update add consolefont boot

cp ru-utf.map.gz /usr/share/keymaps/xkb/
sed -i 's/keymap="us"/keymap="ru-utf"/' /etc/conf.d/loadkeys
sed -i 's/dumpkeys_charset="no"/dumpkeys_charset="yes"/' /etc/conf.d/loadkeys
rc-update add loadkeys boot

--------------------------------------------------

Bootloaders.

REFIND.

apk install refind
refind-install --alldrivers
echo '"Alpine" "modules=loop,squashfs,sd-mod,usb-storage quiet initrd=\boot\intel-ucode.img initrd=\boot\amd-ucode.img initrd=\boot\initramfs-lts"' > /media/sdXY/boot/refind_linux.conf

SYSLINUX.

apk add syslinux
dd bs=440 count=1 conv=notrunc if=/usr/share/syslinux/gptmbr.bin of=/dev/sda
or
dd bs=440 count=1 conv=notrunc if=/usr/share/syslinux/mbr.bin of=/dev/sda

extlinux --install /boot

EFI.

Assuming /mnt is a FAT32 partition of type EF00 and /boot belongs to the rootfs created after running setup-disk:

mkdir -p /mnt/EFI/syslinux
cp /usr/share/syslinux/efi64/* /mnt/EFI/syslinux/
cp /boot/extlinux.conf /mnt/EFI/syslinux/syslinux.cfg
cp /boot/vmlinuz* /mnt/
cp /boot/initramfs* /mnt/
You may need to modify /mnt/EFI/syslinux/syslinux.cfg to change the paths to absolute paths (just add a / in front of the vmlinuz/initramfs entries), or copy the files to /mnt/EFI/syslinux instead (XXX: untested).

GRUB.

apk del syslinux
apk add grub grub-bios os-prober breeze-grub

apk add grub-efi
grub-install /dev/vda
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg

nano /etc/default/grub
GRUB_DISABLE_OS_PROBER=false

grub-mkconfig -o /boot/grub/grub.cfg

--------------------------------------------------

WIRWGUARD.

apk add wireguard-tools
modprobe wireguard
# /etc/modules
echo "wireguard" >> /etc/modules

wg genkey | tee privatekey | wg pubkey > publickey

Interface]
Address = 10.123.0.1/24
ListenPort = 45340
PrivateKey = SG1nXk2+kAAKnMkL5aX3NSFPaGjf9SQI/wWwFj9l9U4= # the key from the previously generated privatekey file
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE;iptables -A FORWARD -o %i -j ACCEPT
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE;iptables -D FORWARD -o %i -j ACCEPT

wg-quick up wg0

wg-quick down wg0

--------------------------------------------------

Bringing up an interface using ifupdown-ng WIRWGUARD.

apk add wireguard-tools-wg

nano /etc/network/interfaces

auto wg0
iface wg0 inet static
       requires eth0
       use wireguard
       address 192.168.42.1
       post-up iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE;iptables -A FORWARD -o wg0 -j ACCEPT
       post-down iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE;iptables -D FORWARD -o wg0 -j ACCEPT

This config will automatically:

	bring the WireGuard interface up after the eth0 interface
	assign a config to this interface (which you have previously created)
	setup the interface address and netmask
	add the route once the interface is up
	remove the interface when it goes down
	enable traffic forwarding (the post-up and post-down lines; requires iptables) 
		(note that this is not required unless you want peers to be able to access external resources like the internet)

ifup wg0
ifdown wg0

f your interface config is not stored under /etc/wireguard/ you need to specify a wireguard-config-path as well.

Enable IP Forwarding

If you intend for peers to be able to access external resources (including the internet), you will need to enable forwarding. Edit the file /etc/sysctl.conf (or a .conf file under /etc/sysctl.d/) and add the following line.

net.ipv4.ip_forward = 1
Then either reboot or run sysctl -p /etc/sysctl.conf to reload the settings. To ensure forwarding is turned on, run sysctl -a | grep ip_forward and ensure net.ipv4.ip_forward is set to 1. To make the change permanent across reboots, you may need to enable the sysctl service: rc-update add sysctl.


--------------------------------------------------

DOCKER DOCKER_COMPOSE.

apk add docker
addgroup username docker

rc-update add docker boot
service docker start

sysctl -w kernel.grsecurity.chroot_deny_chmod=0
sysctl -w kernel.grsecurity.chroot_deny_mknod=0

apk add docker-compose

To install docker-compose, first install pip:

apk add py-pip python3-dev libffi-dev openssl-dev gcc libc-dev make
pip3 install docker-compose

--------------------------------------------------

Isolate containers with a user namespace

adduser -SDHs /sbin/nologin dockremap
addgroup -S dockremap
echo dockremap:$(cat /etc/passwd|grep dockremap|cut -d: -f3):65536 >> /etc/subuid
echo dockremap:$(cat /etc/passwd|grep dockremap|cut -d: -f4):65536 >> /etc/subgid
add to /etc/docker/daemon.json

{  
        "userns-remap": "dockremap"
}
You may also consider these options : '

       "experimental": false,
       "live-restore": true,
       "ipv6": false,
       "icc": false,
       "no-new-privileges": false

--------------------------------------------------

Archlinux cups recomended.

apk add cups cups-lang cups-libs cups-pdf print-manager

По умолчанию файлы PDF хранятся в /var/spool/cups-pdf/имя_пользователя. 
Местоположение можно изменить в /etc/cups/cups-pdf.conf.

# Добавить локальный принтер - Cups-PDF
$ mkdir ~/cups-pdf
# Настраиваем конфиг
$ sudo nano /etc/cups/cups-pdf.conf
...
Out /home/mikl/cups-pdf/
...
TitlePref 1
...
DecodeHexStrings 1
...


http://localhost:631/

cups.service
cups.socket

При активации cups.socket и выключении cups.service, CUPS запускается только тогда, когда программа хочет его использовать.

Gutenprint Printer Drivers: Canon, Epson, Lexmark, Sony, Olympus, PCL.
sudo pacman -S gutenprint foomatic-db-gutenprint-ppds

Foomatic Printer Drivers.
Чтобы использовать foomatic, установите foomatic-db-engine и по крайней мере один из пакетов:
foomatic-db - коллекция файлов XML, используемая foomatic-db-engine для генерации файлов PPD.
foomatic-db-ppds - прекомпилированные файлы PPD.
foomatic-db-nonfree - коллекция файлов XML под несвободными лицензиями от производителей принтеров, используемая foomatic-db-engine для генерации файлов PPD.
foomatic-db-nonfree-ppds - прекомпилированные файлы PPD под несвободными лицензиями.

Инструмент для управления заданиями печати и принтерами (KDE):
print-manager

Инструмент настройки принтера GTK+ и апплет состояния (GNOME и другие):
system-config-printer

Настройки сервера CUPS находятся в /etc/cups/cupsd.conf и /etc/cups/cups-files.conf

--------------------------------------------------

###########

alpine-base
alpine-mirrors
alpine-desktop
network-extras
xf86-input-evdev
xf86-video-vmware
xf86-video-intel
xf86-video-ati
xf86-video-nv
linux-firmware-nvidia
tzdata

###########







