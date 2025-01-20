FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:6d51e4a8e10dfe334f8e2d15bb81b1ed2580ea9cb874b644acc720eda7022b54

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
