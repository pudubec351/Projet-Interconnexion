set -e
ip link set eth1 up
ip addr add 10.1.40.7/24 dev eth1
ip route add default via 10.1.40.1


rm -f /etc/nginx/sites-enabled/default                      # retire le site par défaut de Debian
ln -sf /srv/web/siteweb1.conf /etc/nginx/sites-enabled/siteweb1.conf   # active notre site
nginx                                                 # démarre le serveur

