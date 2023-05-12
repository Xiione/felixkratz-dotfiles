#!/bin/bash

ALIAS="Control Center,Battery"

battery_alias=(
  alias.color="$WHITE"
  icon.drawing=off
  label.drawing=off
  padding_left=0
  padding_right=0
  popup.drawing=off
  update_freq=3
  updates=on
)

sketchybar --add alias "$ALIAS" right                                   \
           --rename "$ALIAS" battery_alias                              \
           --set battery_alias "${battery_alias[@]}"
