#Creer l'image du serveur d'annuaire de l'entreprise
FROM alpine-base
  RUN echo "slapd slapd/no_configuration boolean false" | debconf-set-selections \
   && echo "slapd slapd/domain string sw1.as1"          | debconf-set-selections \
   && echo "slapd shared/organization string Ent1"      | debconf-set-selections \
   && echo "slapd slapd/password1 password adminldap"   | debconf-set-selections \
   && echo "slapd slapd/password2 password adminldap"   | debconf-set-selections \
   && apt-get update && apt-get install -y --no-install-recommends \
          slapd ldap-utils \
      && rm -rf /var/lib/apt/lists/*

