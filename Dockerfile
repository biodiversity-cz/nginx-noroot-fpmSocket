FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:144210beee75048a0db053eada2e4555fe70724a122a4049aac9acb8bb1de9bf

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
