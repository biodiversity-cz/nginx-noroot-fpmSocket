FROM ghcr.io/nginxinc/nginx-unprivileged:latest

COPY default.conf /etc/nginx/conf.d/default.conf