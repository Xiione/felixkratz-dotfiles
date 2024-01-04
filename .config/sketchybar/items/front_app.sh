#!/bin/bash

front_app=(
  icon.drawing=off
  padding_left=0
  label.font="$FONT:Black:12.0"
  label.background.color="$CLICK"
  icon.background.drawing=on
  display=active
  script="$PLUGIN_DIR/front_app.sh"
  click_script="open -a 'Mission Control'"
)

sketchybar --add item front_app left         \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched
