#!/opt/homebrew/bin/bash
# up-to-date ver for to-lowercase syntax

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

window_state() {
  WINDOW=$(yabai -m query --windows --window)
  STACK_INDEX=$(echo "$WINDOW" | jq '.["stack-index"]')

  COLOR=$BAR_BORDER_COLOR
  ICON=""

  if [ "$(echo "$WINDOW" | jq '.["is-floating"]')" = "true" ]; then
    ICON+=$YABAI_FLOAT
    COLOR=$MAGENTA
  elif [ "$(echo "$WINDOW" | jq '.["has-fullscreen-zoom"]')" = "true" ]; then
    ICON+=$YABAI_FULLSCREEN_ZOOM
    COLOR=$GREEN
  elif [ "$(echo "$WINDOW" | jq '.["has-parent-zoom"]')" = "true" ]; then
    ICON+=$YABAI_PARENT_ZOOM
    COLOR=$BLUE
  elif [[ $STACK_INDEX -gt 0 ]]; then
    LAST_STACK_INDEX=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
    ICON+=$YABAI_STACK
    LABEL="$(printf "[%s/%s]" "$STACK_INDEX" "$LAST_STACK_INDEX")"
    COLOR=$RED
  fi

  args=(--set "$NAME" icon.color="$COLOR")

  [ "$LABEL" = "" ] && args+=(label.width=0) \
                  || args+=(label="$LABEL" label.width=40)

  [ "$ICON" = "" ] && args+=(icon.width=0) \
                 || args+=(icon="$ICON" icon.width=30)

  sketchybar -m "${args[@]}"
}

windows_on_spaces() {
  CURRENT_SPACES="$(yabai -m query --displays | jq -r '.[].spaces | @sh')"

  args=(--animate sin 10)

  while read -r line
  do
    for space in ${line[@]}
    do
      icon_strip=" "
      raw_apps=$(yabai -m query --windows --space "$space" | jq -r ".[].app")

      if [ "$raw_apps" != "" ]; then
        unique_apps=$(echo "$raw_apps" | sort | uniq -i)
        while read -r app
        do
          icon_strip+=" $("$CONFIG_DIR"/plugins/icon_map.sh "$app")"
        done <<< "$unique_apps"
      else
        icon_strip=" —"
      fi
      args+=(--set space."$space" label="$icon_strip" label.drawing=on)
    done
  done <<< "$CURRENT_SPACES"

  sketchybar -m "${args[@]}"
}

space_windows_change() {
  args=(--animate sin 10)

  space="$(echo "$INFO" | jq -r '.space')"
  apps="$(echo "$INFO" | jq -r '.apps | keys[]')"

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi
  args+=(--set space."$space" label="$icon_strip")

  sketchybar -m "${args[@]}"
}


space_change() {
  CURRENT_SPACES="$(yabai -m query --displays | jq -r '.[].spaces | @sh')"

  CUR_SPACE="$(echo "$INFO" | jq -r '.[]')"

  args=(--set '/space\..*/' background.drawing=on)

  while read -r line
  do
    for space in ${line[@]}
    do
      if [ "${CUR_SPACE}" = "$space" ]; then
        continue
      fi
      border_color=$(sketchybar --query space."$space" | jq -r ".geometry.background.border_color")

      case "${border_color,,}" in
        "${RECENT_SPACE,,}") border_color="$BACKGROUND_2"
        ;;
        "${RECENT_SPACE_PRE,,}") border_color="$RECENT_SPACE"
        ;;
      esac

      args+=(--set space."$space" background.border_color="$border_color")
    done
  done <<< "$CURRENT_SPACES"

  sketchybar -m "${args[@]}"
}

mouse_clicked() {
  yabai -m window --toggle float
  window_state
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "forced") exit 0
  ;;
  "window_focus" | "float_change") window_state 
  ;;
  "space_windows_change") space_windows_change
  ;;
  "space_change") space_change
  ;;
  "windows_on_spaces") windows_on_spaces
  ;;
esac
