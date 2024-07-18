# nginx-noroot-fpmSocket
Unprivileged Nginx container with PHP-FPM socket prepared. Listen port 8080, see https://github.com/nginxinc/docker-nginx-unprivileged.

In combination with the [second container](https://github.com/krkabol/php-fpm-noroot-socket) provides a set to run PHP-FPM powered application in an unprivileged Kubernetes cluster settings. The paths are fitted to the [Nette Framework](https://nette.org/) habits.

Derived from [Dockette](https://github.com/dockette/web) (with a single and privileged container) and Matthew Palmer [article](https://matthewpalmer.net/kubernetes-app-developer/articles/php-fpm-nginx-kubernetes.html) (using tcp socket instead of unix php-fpm).

## Docker-compose
Named volume *sock* shares the php-fpm unix socket between both containers.
Add test script *index.php* into the mounted folder ./app with content ```<?php phpinfo();``` and check http://localhost.

```yaml
version: '3'
services:
  php-fpm:
    image: ghcr.io/krkabol/php-fpm-noroot-socket:main
    volumes:
      - ./app:/srv/www
      - sock:/sock
    user: 1000:1000

  nginx:
    image: ghcr.io/krkabol/nginx-noroot-fpmsocket:main
    depends_on:
      - php-fpm
    ports:
      - 80:8080
    volumes:
      - ./app:/srv/www
      - sock:/sock
    user: 1000:1000

volumes:
  sock:
```

## Kubernetes Deployment
Volume *shared-socket* keeps the socket, *shared-files* is your application - originating from /app of the PHP container, by startup hook copied into the final destination (and shared with Nginx).
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: xxx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: xxx
  template:
    metadata:
      labels:
        app: xxx
    spec:
      securityContext:
        runAsUser: 1000
        runAsNonRoot: true
        seccompProfile:
          type: RuntimeDefault
      containers:
        - name: php
          image: xxx #image derived from ghcr.io/krkabol/php-fpm-noroot-socket:main - in the Dockerfile is your app  COPY to /app (!), see Palmer's article
          imagePullPolicy: Always
          securityContext:
            allowPrivilegeEscalation: false
            capabilities:
              drop:
                - ALL
          volumeMounts:
            - name: shared-files
              mountPath: /srv
            - name: shared-socket
              mountPath: /sock
          lifecycle:
            postStart:
              exec:
                command: [ "/bin/sh", "-c", "cp -r /app/. /srv" ]
        - name: nginx
          image: ghcr.io/krkabol/nginx-noroot-fpmsocket:main
          securityContext:
            allowPrivilegeEscalation: false
            capabilities:
              drop:
                - ALL
          ports:
            - containerPort: 8080
          volumeMounts:
            - name: shared-files
              mountPath: /srv
            - name: shared-socket
              mountPath: /sock
      volumes:
        - name: shared-files
          emptyDir: { }
        - name: shared-socket
          emptyDir: { }
```