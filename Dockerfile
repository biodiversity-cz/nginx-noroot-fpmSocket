FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:4d2fcc2a6d0254a6f511be17dfafddbd1373d5a3d3c8449c7eeec251fdd89aa2

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
