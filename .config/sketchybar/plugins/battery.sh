#!/bin/bash

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(echo "$BATTERY_INFO" | grep 'AC Power')

DRAW_ICON=off

sketchybar --set wifi_ssid label="None"

if [[ $CHARGING != "" ]]; then
  DRAW_ICON=on
fi

sketchybar --set battery_percentage icon.drawing=$DRAW_ICON label="${PERCENTAGE}%"

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
