#!/bin/bash

CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"
CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"

if [ "$SSID" = "" ]; then
    sketchybar --set wifi_ssid label="None"
    sketchybar --set wifi_txrate label="0 Mbps"
else
    sketchybar --set wifi_ssid label="$SSID"
    sketchybar --set wifi_txrate label="${CURR_TX} Mbps"
fi

popup() {
  sketchybar --set "$NAME" popup.drawing="$1"
}

case "$SENDER" in
  # "routine"|"forced") update
  # ;;
  "mouse.entered") popup on
  ;;
  "mouse.exited"|"mouse.exited.global") popup off
  ;;
  "mouse.clicked") popup toggle
  ;;
esac
