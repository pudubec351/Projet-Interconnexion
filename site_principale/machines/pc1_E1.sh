set -e

ip link set eth1 up
#ip addr add 10.1.20.2/24 dev eth1
#ip route add default via 10.1.20.1
dhclient -v eth1 #demande l'adresse au serveur dhcp
