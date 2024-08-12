FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:e0b90e4ae842abc9b3eecba9344b0f7c11276346e548659a500ecea18771687c

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
