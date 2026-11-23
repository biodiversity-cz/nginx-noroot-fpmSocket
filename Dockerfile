FROM ghcr.io/nginx/nginx-unprivileged:trixie@sha256:4ac6145e433b1adc0880714fe3402680f5e599f1a264148253d6a94a4c000776

MAINTAINER Petr Novotný <novotp@natur.cuni.cz>
LABEL org.opencontainers.image.source=https://github.com/biodiversity-cz/nginx-noroot-fpmSocket
LABEL org.opencontainers.image.description="no root NGINX with prepared UNIX socket PHP/FPM"

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir -p /sock /var/www/html && \
    chown -R www:www /sock /srv /var/www/html && \
    chmod -R 777 /sock
USER www

COPY main.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY custom_locations.conf /etc/nginx/includes/custom_locations.conf

COPY --chown=www:www maintenance.html /var/www/html/maintenance.html
