FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:d857c0426a5ff4870c8c0924fdedb52e3bf7af52c9dd4726b567fff587f181ae

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
