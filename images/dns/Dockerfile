# Serveur DNS : BIND9 (named)
FROM alpine-base
RUN apt-get update && apt-get install -y --no-install-recommends \
        bind9 bind9-utils \
    && rm -rf /var/lib/apt/lists/*
