set -e

#Config du switch sans les VLANS.
#ip link add name br0 type bridge
#for port in eth1 eth2 eth3 eth4 eth5 eth6 eth7 eth8 eth9; do
#    ip link set "$port" master br0
#    ip link set "$port" up#
#done
#ip link set br0 up

#Config du switch avec les VLANS.

ip link add name br0 type bridge vlan_filtering 1

# Brancher toutes les prises et retirer le VLAN 1 mis par défaut
for port in eth1 eth2 eth3 eth4 eth5 eth6 eth7 eth8 eth9; do
      ip link set "$port" master br0
      bridge vlan del dev "$port" vid 1
done

# Trunk vers le routeur : Peut recevoir toutes les trames
bridge vlan add dev eth1 vid 10
bridge vlan add dev eth1 vid 20
bridge vlan add dev eth1 vid 30
bridge vlan add dev eth1 vid 40


# Ports access :associe un pid à aux interfaces, trames sans étiquette
bridge vlan add dev eth2 vid 20 pvid untagged          # pc1
bridge vlan add dev eth3 vid 30 pvid untagged          # téléphone

for port in eth4 eth5 eth6 eth7 eth8 eth9; do          # serveurs
      bridge vlan add dev "$port" vid 40 pvid untagged
done


for port in eth1 eth2 eth3 eth4 eth5 eth6 eth7 eth8 eth9; do
      ip link set "$port" up
done


ip link set br0 up
