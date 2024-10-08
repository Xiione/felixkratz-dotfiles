#!/bin/bash

yabai=(
  icon.width=0
  label.width=0
  script="$PLUGIN_DIR/yabai.sh"
  icon.font="$FONT:Bold:16.0"
  background.color="$CLICK"
)

sketchybar --add event window_focus               \
           --add event windows_on_spaces          \
           --add event float_change               \
           --add item yabai left                  \
           --set yabai "${yabai[@]}"              \
           --subscribe yabai window_focus         \
                             space_change         \
                             space_windows_change \
                             windows_on_spaces    \
                             mouse.clicked        \
                             float_change
