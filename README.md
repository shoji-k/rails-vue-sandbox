![](https://github.com/shoji-k/rails-sandbox/workflows/Ruby%20CI/badge.svg)

[api docs](https://stoplight.io/p/docs/gh/shoji-k/rails-vue-sandbox/src/apidocs/openapi.json)

### start developing

```bash
docker compose build
docker compose run --rm rails bin/rails db:create
docker compose run --rm rails bin/rails db:migrate
docker compose run --rm rails bin/rails db:seed_fu
```

then

```bash
docker compose up
```

### production

```bash
cp docker-compose.override.yml.production docker-compose.override.yml
docker compose up
```