FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:ec783757c240e99a713eba1def9a88b983a133da215f517ed2d9a6fd734c2ad1

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
