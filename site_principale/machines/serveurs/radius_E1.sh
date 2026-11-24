set -e
ip link set eth1 up
ip addr add 10.1.40.6/24 dev eth1
ip route add default via 10.1.40.1
