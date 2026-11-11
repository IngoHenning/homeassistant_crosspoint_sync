# Upstream CrossPoint Sync 0.1.0 (git tag v0.1.0, commit cf86947)
# Digest at time of writing: sha256:00ddab035fd5b19b3866da7ff41aba703f45bff82047c370af997425734f313b
ARG CROSSPOINT_VERSION=0.1.0
FROM ghcr.io/crosspoint-reader/crosspoint-sync:${CROSSPOINT_VERSION}

ARG BUILD_ARCH
ARG BUILD_VERSION

USER root

RUN apk add --no-cache nginx jq \
 && mkdir -p /run/nginx /etc/nginx/http.d /usr/share/licenses/crosspoint-sync \
 && rm -f /etc/nginx/http.d/default.conf

COPY run.sh /run.sh
RUN chmod +x /run.sh

# MIT requires the upstream notice to travel with every copy of the software
COPY THIRD-PARTY-NOTICES.md /usr/share/licenses/crosspoint-sync/

LABEL \
  io.hass.type="app" \
  org.opencontainers.image.title="CrossPoint Sync" \
  org.opencontainers.image.description="KOSync-compatible sync server for CrossPoint, CrossInk and KOReader" \
  org.opencontainers.image.licenses="MIT"

CMD ["/run.sh"]
