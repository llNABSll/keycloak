# Partir de l'image officielle Keycloak
FROM quay.io/keycloak/keycloak:24.0

# Copier ton realm JSON dans le répertoire d'import de Keycloak
COPY paye-ton-kawa.json /opt/keycloak/data/import/paye-ton-kawa.json

# Démarrer en mode dev avec import du realm
CMD ["start-dev", "--import-realm"]
