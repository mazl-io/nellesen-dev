# Tiny static host: Caddy serving the public/ directory.
# Coolify build pack = Dockerfile, exposed port = 80.
FROM caddy:2-alpine

COPY Caddyfile /etc/caddy/Caddyfile
COPY public/ /srv

EXPOSE 80
