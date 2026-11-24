set -e
ip link set eth1 up
ip addr add 10.1.40.3/24 dev eth1
ip route add default via 10.1.40.1



# Préparation et démarage du serveur
ulimit -n 1024   # Évite que slapd ne sature la RAM sous Docker                                  
mkdir -p /run/slapd && chown openldap:openldap /run/slapd   
slapd -h "ldap:/// ldapi:///" -u openldap -g openldap  # Lance le démon en arrière-plan     
sleep 1 #permet d'assurer que le serveur est bien démarré avant l'étape d'après

#Importe la structure initiale de l'annuaire
ldapadd -x -H ldap://localhost \
        -D cn=admin,dc=sw1,dc=as1 -w adminldap \
        -f /srv/ldap/base.ldif                   # remplit l'arbre

