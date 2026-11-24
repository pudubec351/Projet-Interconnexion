set -e

#Creation des dockers

# Image à utiliser selon le rôle de la machine (images construites par ../images/build.sh)
image() {
    case "$1" in
        Switch_*)      echo alpine-switch ;;
        routeur_*)     echo alpine-routeur ;;
        dhcp_*)        echo alpine-dhcp ;;
        ns1_*)         echo alpine-dns ;;
        Serveur_web_*) echo alpine-web ;;
        idap_*)		echo alpine-ldap;;
        *)             echo alpine-base ;;    # equipments pas encore faits
    esac
}

#Permet de monter les fichiers de configurations sur les dockers correspondants
volumes() {
    case "$1" in
        dhcp_*) echo "-v $PWD/configs/dhcp/dhcpd.conf:/etc/dhcp/dhcpd.conf:ro" ;;
 	Serveur_web_*) echo "-v $PWD/configs/web/:/srv/web:ro";;  
 	ns1_*) echo "-v $PWD/configs/dns/named.conf.local:/etc/bind/named.conf.local:ro -v $PWD/configs/dns/db.sw1.as1:/etc/bind/db.sw1.as1:ro" ;; 
 	idap_*) echo "-v $PWD/configs/ldap/:/srv/ldap:ro" ;;
    esac
}


for f in machines/*.sh machines/serveurs/*.sh; do
    n=$(basename "$f" .sh)          # machines/pc1_E1.sh → pc1_E1
    docker run -d --name "$n" --hostname "$n" --network none --privileged $(volumes "$n") "$(image "$n")" sleep inf
done




#Branchement des cables réseaux entre les conteners et le switch (+ ajoute interfaces reseaux)

 pid() { docker inspect -f '{{.State.Pid}}' "$1"; } #Recupère le pid d'un équipement pour y accéder


cable() {
    sudo ip link add name "$2" netns "$(pid "$1")" type veth peer name "$4" netns "$(pid "$3")"
  }


#Chaque ligne branche un câble entre la prise eth1 de l'équipement et une prise différente du switch.
cable routeur_E1      eth1  Switch_E1 eth1
cable pc1_E1          eth1  Switch_E1 eth2
cable TelephoneSIP_E1 eth1  Switch_E1 eth3

cable dhcp_E1         eth1  Switch_E1 eth4
cable idap_E1         eth1  Switch_E1 eth5
cable ns1_E1         eth1  Switch_E1 eth6
cable radius_E1         eth1  Switch_E1 eth7
cable Serveur_web_E1         eth1  Switch_E1 eth8
cable pbx_E1         eth1  Switch_E1 eth9





#Execution des scripts sur chaque machines


 config() { echo "== configuration de $1"; docker exec -i "$1" sh < "$2"; }

  config Switch_E1  machines/Switch_E1.sh        
  config routeur_E1 machines/routeur_E1.sh   
     
  for f in machines/serveurs/*.sh; do            
      config "$(basename "$f" .sh)" "$f"
  done
  
  #configure les clients en dernier pour DHCP
  config pc1_E1          machines/pc1_E1.sh     
  config TelephoneSIP_E1 machines/TelephoneSIP_E1.sh



