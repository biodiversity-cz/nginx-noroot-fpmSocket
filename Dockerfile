FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG $GID www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
