#!/bin/bash

ALIAS="KeePassXC,Item-0"

keepass_alias=(
  alias.color="$WHITE"
  click_script="$PLUGIN_DIR/keepass.sh"
  icon.drawing=off
  label.drawing=off
  padding_left=0
  padding_right=0
  width=dynamic
)

sketchybar --add alias "$ALIAS" right                \
           --rename "$ALIAS" keepass_alias           \
           --set keepass_alias "${keepass_alias[@]}"
