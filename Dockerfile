FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:78e0a42a309fd21299b3618fdcd20d1adddb43531a3a4483df858b867a58e546

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
