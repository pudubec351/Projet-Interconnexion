set -e
ip link set eth1 up
ip addr add 10.1.40.4/24 dev eth1
ip route add default via 10.1.40.1


named-checkconf # vérifie la syntaxe de la config
named -u bind  # démarre le serveur 

