#!/bin/bash
subnet=172.16.14.0
mask=255.255.255.192
gateway=172.16.14.1
serv1=172.16.14.21
interface=eth1
iprange=("172.16.14.10" "172.16.14.20" "172.16.14.30" "172.16.14.40" "08:00:27:69:b6:c2" "08:00:27:69:b6:c3" "08:00:27:69:b6:c4" "08:00:27:69:b6:c5")

source /etc/os-release
echo "Your OS is $ID"

function dhcpconfigfunc {
# Задать интерфейс для выдачи dhcp
 cat > /etc/default/isc-dhcp-server <<EOF
INTERFACESv4="$interface"
INTERFACESv6=""
EOF

 cat > /etc/dhcp/dhcpd.conf <<EOF
option domain-name-servers 8.8.8.8, 8.8.4.4;
default-lease-time 3600;
max-lease-time 7200;

class "black-hole" {
    match substring (hardware, 1, 6);
    ignore booting;
}
subclass "black-hole" $1;
subclass "black-hole" $2;

subnet $subnet netmask $mask {

  range $3 $4;
  option subnet-mask $mask;
  option routers $gateway;
}
EOF
}

case $ID in

#UBUNTU server
 ubuntu)

echo "Installing $ID DHCP Server"
sudo apt-get update
sudo apt-get -y upgrade

 cat > /etc/netplan/01-netcfg.yaml <<EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      optional: true
      dhcp4: yes
    $interface:
      optional: true
      dhcp4: no
      addresses: [$gateway/26]
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
EOF

sudo netplan apply # применить настройки
sudo netplan generate # сохранить текущие настройки в файл конфига networkd
sudo apt install -y isc-dhcp-server # install dhcp server

dhcpconfigfunc ${iprange[4]} ${iprange[5]} ${iprange[0]} ${iprange[1]} # конфиги

sudo systemctl restart isc-dhcp-server.service
;;

#CENTOS server
centos|rhel)

echo "Installing $ID DHCP Server"
sudo yum install -y dhcp

dhcpconfigfunc ${iprange[2]} ${iprange[3]} ${iprange[6]} ${iprange[7]} # конфиги

 cat > /etc/sysconfig/network-scripts/ifcfg-eth1 <<EOF
TYPE="Ethernet"
BOOTPROTO="none"
NAME="$interface"
IPADDR="$serv1"
NETMASK="$mask"
GATEWAY="$gateway"
DEVICE="$interface"
ONBOOT="yes"
PEERDNS=no
EOF
sudo systemctl enable dhcpd
sudo systemctl start dhcpd
;;

# ALPINE client
 alpine)
 
echo "Installing $ID Client"
 cat >> /etc/network/interfaces <<EOF
auto $interface
iface $interface inet dhcp
EOF
sudo service networking restart
sudo udhcpc $interface
;; 
esac