# Image commune (Debian, comme les salles de TP) : outils réseau de debug et de capture
FROM debian:trixie-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
        iproute2 iputils-ping traceroute tcpdump dnsutils curl procps \
        isc-dhcp-client \
    && rm -rf /var/lib/apt/lists/*
CMD ["sleep", "inf"]
