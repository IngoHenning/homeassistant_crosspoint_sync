#!/bin/sh
set -e

OPTIONS=/data/options.json
HACK=false
TRUST=false

if [ -f "$OPTIONS" ]; then
  key=$(jq -r '.token_enc_key // ""' "$OPTIONS")
  [ -n "$key" ] && export TOKEN_ENC_KEY="$key"
  export REGISTRATION_DISABLED="$(jq -r '.registration_disabled // false' "$OPTIONS")"
  export ALLOW_HTTP_LOCALHOST="$(jq -r '.allow_http_localhost // false' "$OPTIONS")"
  HACK="$(jq -r '.https_hack // false' "$OPTIONS")"
  TRUST="$(jq -r '.trust_proxy // false' "$OPTIONS")"
fi

if [ "$HACK" = "true" ] || [ "$TRUST" = "true" ]; then
  export TRUST_PROXY=true
else
  export TRUST_PROXY=false
fi

mkdir -p /run/nginx /etc/nginx/http.d

{
  cat <<'EOF'
error_log stderr warn;
server {
    listen 8080;
    server_name _;
    access_log off;
    client_max_body_size 64m;
    proxy_http_version 1.1;
    proxy_set_header Host              $http_host;
    proxy_set_header X-Real-IP         $remote_addr;
    proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto "";
EOF

  if [ "$HACK" = "true" ]; then
    cat <<'EOF'

    location /api/v1/connectors {
        proxy_set_header Host              $http_host;
        proxy_set_header X-Real-IP         $remote_addr;
        proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;
        proxy_pass http://127.0.0.1:8081;
    }
EOF
  fi

  cat <<'EOF'

    location / {
        proxy_pass http://127.0.0.1:8081;
        proxy_buffering off;
        proxy_read_timeout 300s;
    }
}
EOF
} > /etc/nginx/http.d/crosspoint.conf

if [ ! -s /etc/nginx/http.d/crosspoint.conf ]; then
  echo "[FATAL] /etc/nginx/http.d/crosspoint.conf was not written" >&2
  echo "[FATAL] check AppArmor rules for /etc/nginx/http.d/ (needs rw)" >&2
  exit 1
fi

echo "[INFO] https_hack=$HACK trust_proxy=$TRUST_PROXY allow_http_localhost=$ALLOW_HTTP_LOCALHOST"
nginx -t
echo "--- X-Forwarded-Proto in generated config ---"
grep -n 'X-Forwarded-Proto' /etc/nginx/http.d/crosspoint.conf || echo "(none)"

export PORT=8081
export LISTEN_ADDRESS=127.0.0.1

nginx -g 'daemon on;'
exec node dist/index.js
