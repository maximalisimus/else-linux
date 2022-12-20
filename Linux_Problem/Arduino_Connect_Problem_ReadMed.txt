
/etc/modules-load.d/arduino.conf
cdc_acm

sudo modprobe cdc_acm
sudo usermod -aG uucp,tty UserName

sudo pacman -Syy archlinux-keyring
sudo pacman -S arduino arduino-avr-core arduino-docs avr-binutils avr-gcc avr-libc avrdude

https://github.com/juliagoda/CH341SER.git
install CH341SER.tar.gz


CHINA Original (Unable to compile on Archlinux x64.): https://www.wch.cn/downloads/CH341SER_LINUX_ZIP.html


https://forum.manjaro.org/t/cant-connect-serial-port-error-ch341-uart-disconnected-from-ttyusb0/87208/2

$ sudo mv /usr/lib/udev/rules.d/90-brltty-device.rules /usr/lib/udev/rules.d/90-brltty-device.rules.disabled
$ sudo mv /usr/lib/udev/rules.d/90-brltty-uinput.rules /usr/lib/udev/rules.d/90-brltty-uinput.rules.disabled
$ sudo udevadm control --reload-rules

-------------------------------------

sudo pacman -Qi brltty



