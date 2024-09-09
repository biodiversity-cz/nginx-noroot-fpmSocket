FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:0569e319d06556564ad40882ed35231461d06bec788b5aec00b83b6e9f3ced1a

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
