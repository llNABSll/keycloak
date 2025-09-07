# Keycloak – PayeTonKawa Realm

Ce dépôt contient l’export JSON du **realm Keycloak** utilisé par le projet **PayeTonKawa**.
Il permet de centraliser l’authentification et l’autorisation des différents microservices (`product-api`, `order-api`, `customer-api`, etc.).

---

## Contenu

* `paye-ton-kawa.json` → export du realm Keycloak avec :

  * Realm : `paye-ton-kawa`
  * Clients configurés (APIs & Gateway)
  * Rôles (`product:read`, `product:write`, `order:read`, etc.)
  * Utilisateurs de test (si inclus dans l’export)

---

## Utilisation

### 1. Avec Docker Compose

Dans le repo **orchestrateur**, le fichier `docker-compose.yml` est déjà configuré pour importer ce realm automatiquement au démarrage de Keycloak :

```yaml
keycloak:
  image: quay.io/keycloak/keycloak:24.0
  container_name: keycloak
  command: ["start-dev", "--import-realm"]
  environment:
    KEYCLOAK_ADMIN: ${KEYCLOAK_ADMIN}
    KEYCLOAK_ADMIN_PASSWORD: ${KEYCLOAK_ADMIN_PASSWORD}
    KC_HTTP_RELATIVE_PATH: "/auth"
  ports:
    - "8081:8080"
  volumes:
    - ./paye-ton-kawa.json:/opt/keycloak/data/import/paye-ton-kawa.json:ro
```

Il suffit donc de lancer :

```bash
docker compose up -d keycloak
```

Keycloak démarrera avec le realm `paye-ton-kawa` importé.

---

### 2. Import manuel (optionnel)

Si tu veux importer le realm à la main :

1. Lancer Keycloak :

```bash
   docker run --rm -p 8080:8080 quay.io/keycloak/keycloak:24.0 start-dev
```

2. Accéder à l’UI : [http://localhost:8080](http://localhost:8080)
   Identifiant : `admin` / Mot de passe : `admin` (selon variables).

3. Aller dans **Realm Settings → Import** et sélectionner `paye-ton-kawa.json`.

---

## Variables importantes

Dans l’orchestrateur ou les APIs, les URLs Keycloak doivent pointer vers ce realm :

* Issuer :
  `http://localhost/auth/realms/paye-ton-kawa`
* JWKS :
  `http://keycloak:8080/auth/realms/paye-ton-kawa/protocol/openid-connect/certs`

Ces valeurs sont déjà fournies dans le fichier `.env.example` de l’orchestrateur.

---

## Notes

* Ce repo ne contient que l’**export du realm**.
* La configuration de Keycloak (serveur, admin, etc.) est gérée dans le repo **orchestrateur**.
* En cas de modification du realm dans Keycloak, pense à **réexporter** et mettre à jour `paye-ton-kawa.json` ici.

---
