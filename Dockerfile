FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:890b8283159ff3eec13ee426a2cd79d5a7d7a300457074970ea14c75865dc39c

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
