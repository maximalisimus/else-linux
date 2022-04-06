

$ sudo su
$ echo "deb http://ftp.de.debian.org/debian sid main" >> /etc/apt/sources.list.d/ftp.de.debian.org.list

$ apt update
$ apt install netctl -y

$ ls /etc/netctl/examples/

# netctl start profile

# netctl enable profile

# netctl reenable profile

systemctl status netctl

/etc/netctl/my_dhcp_profile
/etc/netctl/my_static_profile

$ cat /etc/netctl/wireless-wpa

Description='A simple WPA encrypted wireless connection using 256-bit PSK'
Interface=wlp2s2
Connection=wireless
Security=wpa
IP=dhcp
ESSID=your_essid
Key=\"64cf3ced850ecef39197bb7b7b301fc39437a6aa6c6a599d0534b16af578e04a

# wpa_supplicant
$ wpa_passphrase your_essid

network={
  ssid="your_essid"
  #psk="passphrase"
  psk=64cf3ced850ecef39197bb7b7b301fc39437a6aa6c6a599d0534b16af578e04a
}

Set default DHCP client

/etc/netctl/hooks/dhcp
#!/bin/sh
DHCPClient='dhclient'

Alternatively, it may also be specified for a specific network interface by creating an executable file /etc/netctl/interfaces/<interface> with the following line:
В качестве альтернативы, он также может быть указан для конкретного сетевого интерфейса путем создания исполняемого файла /etc/netctl/interfaces/<интерфейс> со следующей строкой:

DHCPClient='dhclient'

Minimal WPAConfigSection

Description='A wireless connection using a custom network block configuration'
Interface=wlan0
Connection=wireless
Security=wpa-configsection
IP=dhcp
WPAConfigSection=(
    'ssid="University"'
    'psk="very secret passphrase"'
)

# netctl start wlan0-ssid

Setting the interface down should resolve the problem:

# ip link set wlan0 down
Then retry:

# netctl start wlan0-ssid
2. If the error continues, try again after adding the ForceConnect option:

/etc/netctl/wlan0-ssid
...
ForceConnect=yes
Save it and try to connect with the profile:

# netctl start wlan0-ssid

Then you should increase carrier and up timeouts by adding TimeoutUp= and TimeoutCarrier= to your profile file:
Затем вам следует увеличить время ожидания несущей и up, добавив Timeout Up= и Timeout Carrier = в файл вашего профиля:

/etc/netctl/profile
...
TimeoutUp=300
TimeoutCarrier=300




# netctl reenable profile















