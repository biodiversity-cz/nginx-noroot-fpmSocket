FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:b8b46cac284e53e0037cff0c66ec6bec4131a5880979a5bd73169644a4b024bf

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
