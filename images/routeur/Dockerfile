# Routeur / pare-feu : iptables (TP5) + relais DHCP ISC (dhcrelay)
FROM alpine-base
RUN apt-get update && apt-get install -y --no-install-recommends \
        iptables isc-dhcp-relay \
    && rm -rf /var/lib/apt/lists/*
