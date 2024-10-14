FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:d7f8c13955c20633fc9b7c34a88b973d0727a272f620e9f53d20eb39c3868080

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
