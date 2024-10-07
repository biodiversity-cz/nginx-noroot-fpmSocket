FROM ghcr.io/nginxinc/nginx-unprivileged:bookworm@sha256:ad3c10f55cd4b87b1d6a226cb1b5dd5707c88c8d59082cc4742a90b27d006841

USER root
RUN useradd -u 1000 -ms /bin/bash www && \
    usermod -aG nginx www && \
    mkdir /sock && \
    chown -R www:www /sock /srv
USER www

COPY default.conf /etc/nginx/conf.d/default.conf
