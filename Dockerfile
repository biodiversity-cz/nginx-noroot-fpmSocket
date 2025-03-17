FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:228360b3d6b18001d7c123486d7c267e3278b32d14864ee14f92f35156c34bed

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
