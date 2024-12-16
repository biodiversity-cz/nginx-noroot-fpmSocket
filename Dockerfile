FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:0abb7c408e90f9b2264fd51a9c9525f7a88be5286d040968dddd8534515910bd

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
