FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm

RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG $GID www && \
    mkdir /sock && \
    chown -R www:www /sock /srv

COPY default.conf /etc/nginx/conf.d/default.conf
USER www