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

send_msg() {
  TEXT="$1"
  curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d text="$TEXT" >/dev/null
}

docker events --format '{{.Type}} {{.Action}} {{.Actor.Attributes.name}}' | while read line; do
  case "$line" in
    *"container die "*)
      send_msg "❌ Container died: $line"
      ;;
    *"container restart "*)
      send_msg "🔄 Container restarted: $line"
      ;;
    *"health_status: unhealthy"*)
      send_msg "⚠️ Unhealthy: $line"
      ;;
  esac
done
