FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:d98d0e6a5cd5e5795b3ef2d112240efea63798903d323f3fff2c6451e8a6b02b

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
