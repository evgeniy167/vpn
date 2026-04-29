#!/usr/bin/env bash

set -euo pipefail

BOT_TOKEN="${BOT_TOKEN:-}"
CHAT_ID="${CHAT_ID:-}"

if [[ -f "/opt/proxy-stack/.env" ]]; then
  # shellcheck disable=SC1091
  source /opt/proxy-stack/.env
fi

BOT_TOKEN="${BOT_TOKEN:-${TELEGRAM_BOT_TOKEN:-}}"
CHAT_ID="${CHAT_ID:-${TELEGRAM_CHAT_ID:-}}"

if [[ -z "${BOT_TOKEN}" || -z "${CHAT_ID}" ]]; then
  echo "BOT_TOKEN/CHAT_ID are not set. Export env vars or configure /opt/proxy-stack/.env" >&2
  exit 1
fi

check_port() {
  NAME="$1"
  PORT="$2"

  if ! ss -tulpn | grep -q ":$PORT "; then
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
      -d chat_id="$CHAT_ID" \
      -d text="⚠️ Port down: $NAME / $PORT" >/dev/null
  fi
}

check_port "xray-443" "443"
check_port "hysteria-2053" "2053"
check_port "dante-1080" "1080"
check_port "mtg-8888" "8888"
check_port "mtg-2095" "2095"
