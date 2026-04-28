#!/usr/bin/env bash

BOT_TOKEN="8208805690:AAGA600o2mWMy87lJae-0pk2sTcAn0ZGtTM"
CHAT_ID="342085015"

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
