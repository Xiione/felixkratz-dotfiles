#!/bin/bash

status_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
)

sketchybar --add bracket status brew github.bell wifi_alias battery_alias volume_icon keepass_alias \
           --set status "${status_bracket[@]}"

