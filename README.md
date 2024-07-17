# nginx-noroot-fpmSocket
Unprivileged Nginx container with PHP-FPM socket prepared. Listen port 8080, see https://github.com/nginxinc/docker-nginx-unprivileged.

In combination with the [second container](https://github.com/krkabol/php-fpm-noroot-socket) provides a set to run PHP-FPM powered application in unprivileged Kubernetes cluster settings.

Named volume *sock* shares the php-fpm unix socket between both containers. 

## Docker-compose
Add test script *index.php* into the mounted folder ./app  ```<?php phpinfo();``` and check http://localhost.

```yaml
version: '3'
services:
  php-fpm:
    image: ghcr.io/krkabol/php-fpm-noroot-socket:main
    volumes:
      - ./app:/var/www/html
      - sock:/sock
    user: 1000:1000

  nginx:
    image: ghcr.io/krkabol/nginx-noroot-fpmsocket:main
    depends_on:
      - php-fpm
    ports:
      - 80:8080
    volumes:
      - ./app:/var/www/html
      - sock:/sock
    user: 1000:1000

volumes:
  sock:
```

## Kubernetes