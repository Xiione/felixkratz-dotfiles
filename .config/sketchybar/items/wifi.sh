#!/bin/bash

ALIAS="Control Center,WiFi"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

wifi_alias=(
  alias.color="$WHITE"
  click_script="$POPUP_CLICK_SCRIPT"
  script="$PLUGIN_DIR/wifi.sh"
  icon.drawing=off
  label.drawing=off
  padding_left=0
  padding_right=0
  popup.drawing=off
  update_freq=3
  width=dynamic
)

wifi_ssid=(
  label="SSID"
  icon="$NETWORK"
  icon.align=center
  icon.width=20
)

wifi_txrate=(
  label="0 Mbps"
  icon="$TX"
  icon.align=center
  icon.width=20
)

sketchybar --add alias "$ALIAS" right                                   \
           --rename "$ALIAS" wifi_alias                                 \
           --set wifi_alias "${wifi_alias[@]}"                          \
           --subscribe wifi_alias mouse.entered                         \
                                  mouse.exited                          \
                                  mouse.exited.global                   \
           --add item wifi_ssid popup.wifi_alias                        \
           --set wifi_ssid "${wifi_ssid[@]}"                            \
           --add item wifi_txrate popup.wifi_alias                      \
           --set wifi_txrate "${wifi_txrate[@]}"
