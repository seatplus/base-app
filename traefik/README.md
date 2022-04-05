#Traefik


1) create the external docker network
```shell
docker network create traefik
```

3) start traefik
```shell
docker-compose -f ./docker-compose.yml -f ./docker-compose.prod.yml up -d
```