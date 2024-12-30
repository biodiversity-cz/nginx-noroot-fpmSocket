FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:bc25da1e0ccd3f6b89a012c32ca80dbf7a78d85a15fee697ccb4ebd15263db7d

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
