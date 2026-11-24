set -e

ip link set eth1 up

sysctl -w net.ipv4.ip_forward=1 # active le mode forward


#Config sans VLAN

#ip addr add 10.1.20.1/24 dev eth1
#ip addr add 10.1.30.1/24 dev eth1
#ip addr add 10.1.40.1/24 dev eth1

ip link add link eth1 name eth1.10 type vlan id 10
ip link add link eth1 name eth1.20 type vlan id 20
ip link add link eth1 name eth1.30 type vlan id 30
ip link add link eth1 name eth1.40 type vlan id 40

ip addr add 10.1.10.1/24 dev eth1.10
ip addr add 10.1.20.1/24 dev eth1.20
ip addr add 10.1.30.1/24 dev eth1.30
ip addr add 10.1.40.1/24 dev eth1.40

ip link set eth1.10 up
ip link set eth1.20 up
ip link set eth1.30 up
ip link set eth1.40 up

#Partie connexion avec l'AS
#ip link set eth2 up
#ip addr add  120.0.18.2/8 dev eth1
#ip route add default via 120.0.18.1

#Commande qui fait le lien entre le requête arrivant depuis les vlans et le serveur dhcp
dhcrelay -4 -a -id eth1.10 -id eth1.20 -id eth1.30 -iu eth1.40 10.1.40.2

