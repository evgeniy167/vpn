#!/usr/bin/env bash

BOT_TOKEN="8208805690:AAGA600o2mWMy87lJae-0pk2sTcAn0ZGtTM"
CHAT_ID="342085015"

HOST="127.0.0.1"

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
