set -e
ip link set eth1 up
ip addr add 10.1.40.2/24 dev eth1
ip route add default via 10.1.40.1

touch /var/lib/dhcp/dhcpd.leases #fichier qui contient les add ips déjà attribuées
rm -f /run/dhcpd.pid
dhcpd -4 -cf /etc/dhcp/dhcpd.conf eth1 #lance le serveur dhcp
