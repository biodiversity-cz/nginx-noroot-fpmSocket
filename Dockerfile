FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:46dafc15143e8b97ec827b3dd330639fb509569f7b2c550491962ceeb6d3ae8d

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
