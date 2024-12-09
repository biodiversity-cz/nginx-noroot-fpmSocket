FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:daec951f0566038e3f78b7a8e3e18ecb2ef855ae2f3ee71f28606be9ea248ded

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
