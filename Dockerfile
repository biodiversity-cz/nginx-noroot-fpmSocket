FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:e5d43f3c9867514e04e8630c7e173437e38fdc57c6189495aeb98fcb8feec4b8

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
