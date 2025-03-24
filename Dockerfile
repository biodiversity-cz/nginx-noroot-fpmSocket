FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:2ab8a5f2333e28ddb38819b0eb86fb71b959f5a481cec62cef574570f2d8c573

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
