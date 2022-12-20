

$ sudo su
$ echo "deb http://ftp.de.debian.org/debian sid main" >> /etc/apt/sources.list.d/ftp.de.debian.org.list

$ apt update
$ sudo apt install connman connman-gtk connman-ui

$ sudo connmanctl
agent on
quit
$ sudo systemctl enable connman

sudo cat /var/lib/connman/ethernet_080027a0c313_cable/settings

[ethernet_080027a0c313_cable]
Name=Wired
AutoConnect=true
Modified=2022-02-27T15:57:31.652829Z
IPv4.method=dhcp
IPv6.method=auto
IPv6.privacy=disabled
IPv4.DHCP.LastAddress=10.0.2.4
Nameservers=10.0.2.1;
Proxy.Method=direct

sudo nano /var/lib/connman/ethernet_080027a0c313_cable/settings

[ethernet_080027a0c313_cable]
Name=Wired
AutoConnect=true
Modified=2022-02-27T17:05:49.505305Z
IPv4=10.0.2.2/255.255.255.0/10.0.2.1
IPv6=off
IPv6.privacy=disabled
Nameservers=10.0.2.1;
Proxy.Method=direct
IPv4.method=manual
IPv4.DHCP.LastAddress=10.0.2.4
IPv6.method=auto
IPv4.netmask_prefixlen=24
IPv4.local_address=10.0.2.2
IPv4.gateway=10.0.2.1


/var/lib/connman/ethernet_b827ebaf24d8_cable/settings

[ethernet_b827ebaf24d8_cable]
Name=Wired
AutoConnect=true
Modified=2014-06-19T05:52:09.522465Z
IPv4.method=dhcp
IPv4.DHCP.LastAddress=192.168.1.79
IPv6.method=auto
IPv6.privacy=disabled


/var/lib/connman/<service>

[service_home_ethernet]
Type = ethernet
IPv4 = 192.168.1.42/255.255.255.0/192.168.1.1
IPv6 = 2001:db8::42/64/2001:db8::1
MAC = 01:02:03:04:05:06
Nameservers = 10.2.3.4,192.168.1.99
SearchDomains = my.home,isp.net
Timeservers = 10.172.2.1,ntp.my.isp.net
Domain = my.home

[service_home_wifi]
Type = wifi
Name = my_home_wifi
Passphrase = secret
IPv4 = 192.168.2.2/255.255.255.0/192.168.2.1
MAC = 06:05:04:03:02:01


debian@beaglebone:/var/lib/connman$ sudo cat wifi.config
[service_home]
Type = wifi
Name = yyyyyyyyy
Security = wpa
Passphrase = xxxxxxxxxx
IPv4=192.168.1.4/255.255.255.0/192.168.1.254
IPv6=off
Nameservers=8.8.8.8,8.8.4.4


 /var/lib/connman/wifi_<HASH>_managed_psk/
 
[wifi_<HASH>_managed_psk] 
Name=<SSID>                       #Name of the network 
SSID=544f52414445585f4252         #Name of the network in hexadecimal format    
Favorite=true
IPv4.method=manual                #Method to be used (in this case manual IP)
IPv4.netmask_prefixlen=24
IPv4.local_address=192.168.0.133  #Desired IP address
IPv4.gateway=192.168.0.1
Passphrase=<PASS>                 #Wifi network password
AutoConnect=true

connmanctl enable wifi
connmanctl connect wifi_<HASH>_managed_psk



connmanctl
config ethernet_00142d259a48_cable --ipv4 manual 192.168.10.2 255.255.255.0 192.168.10.1
exit

connmanctl config ethernet_00142d259a48_cable --nameservers 8.8.8.8











