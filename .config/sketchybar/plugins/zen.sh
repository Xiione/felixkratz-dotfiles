#!/bin/bash

zen_on() {
  sketchybar --set wifi drawing=off \
             --set apple.logo drawing=off \
             --set '/cpu.*/' drawing=off \
             --set calendar icon.drawing=off \
             --set separator drawing=off \
             --set front_app drawing=off \
             --set volume_icon drawing=off \
             --set wifi_alias drawing=off \
             --set battery_alias drawing=off \
             --set brew drawing=off \
             --set github.bell drawing=off \
             --set keepass_alias drawing=off
}

zen_off() {
  sketchybar --set wifi drawing=on \
             --set apple.logo drawing=on \
             --set '/cpu.*/' drawing=on \
             --set calendar icon.drawing=on \
             --set separator drawing=on \
             --set front_app drawing=on \
             --set volume_icon drawing=on \
             --set wifi_alias drawing=on \
             --set battery_alias drawing=on \
             --set brew drawing=on \
             --set github.bell drawing=off \
             --set keepass_alias drawing=off
}

if [ "$1" = "on" ]; then
  zen_on
elif [ "$1" = "off" ]; then
  zen_off
else
  if [ "$(sketchybar --query front_app | jq -r ".geometry.drawing")" = "on" ]; then
    zen_on
  else
    zen_off
  fi
fi

