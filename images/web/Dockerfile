# Serveur web : nginx + openssl (certificats de la CA interne)
FROM alpine-base
RUN apt-get update && apt-get install -y --no-install-recommends \
        nginx openssl \
    && rm -rf /var/lib/apt/lists/*
