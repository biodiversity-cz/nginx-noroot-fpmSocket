FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:f748071e0370188bbbe084d20cd32ee1b7eb3a56e97c4ded4c7fae99bd02ea15

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
