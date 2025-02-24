FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:76fb15abad2b5d5f71c5c0de087c364050eb318255797bf855990e36cea24a1c

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
