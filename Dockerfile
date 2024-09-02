FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:c02e7b90670bc37fa7f61b64a266e3a7dc7eb1fda3df753db2a50a6b0657c27d

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
