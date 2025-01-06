FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:09132b78cfbfedfdd1d8b53ae3b018bfff10e3ad6595b2002dd6ed91faec4c48

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
