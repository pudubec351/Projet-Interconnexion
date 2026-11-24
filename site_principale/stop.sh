set -e
# Arrête et supprime toutes les machines du site

for f in machines/*.sh machines/serveurs/*.sh; do
    n=$(basename "$f" .sh)
    docker rm -f "$n" 2>/dev/null && echo "== $n supprimé"
done
