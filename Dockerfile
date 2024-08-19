FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:ad6b833a16dc1d2e2234f70ec65c2fca7987db7d997c62dc13a10678c983a412

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
