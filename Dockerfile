FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:1492491ccceda5ecc90c557c3346dcd24cbf3bf6fb72f3d8b9309c98053db42b

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
