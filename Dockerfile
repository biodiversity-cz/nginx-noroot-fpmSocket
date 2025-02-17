FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:840f33319fb642e32a15a1772400e017e1175891c98afdff3a47871c925cb0e9

MAINTAINER Petr Novotný <novotp@natur.cuni.cz>
LABEL org.opencontainers.image.source=https://github.com/biodiversity-cz/nginx-noroot-fpmSocket
LABEL org.opencontainers.image.description="no root NGINX with prepared UNIX socket PHP/FPM"

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
