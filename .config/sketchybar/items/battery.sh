#!/bin/bash

ALIAS="Control Center,Battery"

battery_alias=(
  alias.color="$WHITE"
  script="$PLUGIN_DIR/battery.sh"
  icon.drawing=off
  label.drawing=off
  padding_left=0
  padding_right=0
  popup.drawing=off
  update_freq=10
  updates=on
)

battery_percentage=(
    label="0%"
    icon="$BOLT"
    width=dynamic
    icon.align=center
    icon.width=20
)

sketchybar --add alias "$ALIAS" right                                   \
           --rename "$ALIAS" battery_alias                              \
           --set battery_alias "${battery_alias[@]}"                    \
           --subscribe battery_alias mouse.entered                      \
                                  mouse.exited                          \
                                  mouse.exited.global                   \
           --add item battery_percentage popup.battery_alias            \
           --set battery_percentage "${battery_percentage[@]}"
