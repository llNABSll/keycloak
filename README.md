# Keycloak (Realm as Code)

**Keycloak** sert d'Identity Provider (OIDC) pour la plateforme.  
Ce répertoire contient le **Dockerfile** et/ou l'**export de realm** pour une importation automatique.

---

## Contenu
- `Dockerfile` : construit une image Keycloak embarquant le **realm** (JSON) dans `/opt/keycloak/data/import/`.
- `realm-payetonkawa.json` : clients, rôles, mappers, utilisateurs de démo.

---

## Build & Run
```bash
docker build -t pk-keycloak:local .
docker run --rm -p 8080:8080 \
  -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin \
  pk-keycloak:local start-dev --import-realm
```
> Avec Compose, assurez-vous que le service Keycloak utilise `start-dev --import-realm` **ou** que les fichiers d’import sont montés dans `/opt/keycloak/data/import/`.

---

## Clients & Rôles (exemples)
- **Clients** : `gateway`, `product-api`, `customer-api`, `order-api`
- **Rôles** : `product:read`, `product:write`, etc.
- **Mappers** : scopes → `realm_access` / `resource_access` selon besoin.

---

## Vérifications rapides
- Découverte OIDC : `/.well-known/openid-configuration`
- JWKS : `/protocol/openid-connect/certs`
- Test token : récupérer un token et appeler une API via Traefik (doit être autorisé)
