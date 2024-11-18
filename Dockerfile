FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:d2ce7dcc2bd61e54ea75e3f07dea8c15e8eb9a0416aecfb12d736fbed5669619

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
