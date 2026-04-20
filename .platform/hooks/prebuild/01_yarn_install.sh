#!/usr/bin/env bash
set -euo pipefail

cd /var/app/staging

mkdir -p tmp/pids tmp/cache
chown -R webapp:webapp tmp

if [ ! -x /usr/bin/node ] && [ ! -x /usr/local/bin/node ]; then
  sudo dnf -y install nodejs
fi

if ! command -v yarn >/dev/null 2>&1; then
  sudo corepack enable || true
fi

yarn install --frozen-lockfile
