

sudo pacman -S bridge-utils --noconfirm

sudo apt install bridge-utils -y

sudo ip link add name br0 type bridge
sudo ip link set br0 up
ip link
sudo ip link set enp0s3 master br0
sudo bridge link
ip addr show
sudo ip addr add 10.0.2.10/24 dev br0
sudo /sbin/ifconfig br0 broadcast 10.0.2.255
sudo /sbin/ifconfig br0 mtu 1000
sudo ip route add 10.0.2.10 via 10.0.2.1
sudo route add default gw 10.0.2.1 br0
/sbin/route

sudo nano /etc/network/interfaces

allow-hotplug br0
auto br0
iface br0 inet static
        address 10.0.2.10
        netmask 255.255.255.0
        gateway 10.0.2.1
        broadcast 10.0.2.255
        # dns-nameservers 10.0.2.1 8.8.8.8
        bridge_ports enp0s3
        bridge_stp off
        bridge_fd 0
        bridge_maxwait 0




sudo apt install connman connman-gtk connman-ui

sudo connmanctl
agent on
quit
sudo systemctl enable connman

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








$ wget https://raw.githubusercontent.com/maximalisimus/for-linux/master/Else_Info/Linux-Networks/debian-netctl/Makefile
# Example opt setup
$ sudo mkdir -p /opt/netctl
$ sudo make DESTDIR=/opt/netctl MANDIR=/usr/share/man DESTSERVICE="" BINDIR=/usr/bin IFPLUGDDIR=/opt/netctl/etc/ifplugd install
# Example uninstall
$ sudo make DESTDIR=/opt/netctl MANDIR=/usr/share/man DESTSERVICE="" BINDIR=/usr/bin IFPLUGDDIR=/opt/netctl/etc/ifplugd uninstall


sudo systemctl status netctl



