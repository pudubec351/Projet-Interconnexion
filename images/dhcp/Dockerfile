# Serveur DHCP : isc-dhcp-server (dhcpd, comme au TP4)
FROM alpine-base
RUN apt-get update && apt-get install -y --no-install-recommends \
        isc-dhcp-server \
    && rm -rf /var/lib/apt/lists/* \
    && touch /var/lib/dhcp/dhcpd.leases
