FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:8c7710010fe4820b0b5562622fe4a24d2d7844172627fae039f4f7762bd18cb9

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
