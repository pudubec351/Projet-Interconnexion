#!/bin/bash
# Construit toutes les images du lab (à lancer avec accès Internet).
# Chaque dossier images/<role>/ donne l'image alpine-<role>.
set -e
cd "$(dirname "$0")"

docker build -t alpine-base base        # en premier : les autres images en dérivent
for d in */; do
    role=${d%/}
    [ "$role" = base ] && continue
    echo "== construction de alpine-$role"
    docker build -t "alpine-$role" "$role"
done
docker images 'alpine-*'
