#!/bin/sh
ws=$(niri msg -j workspaces)
out=$(echo "$ws" | jq -r '.[] | select(.is_focused) | .output')
cur=$(echo "$ws" | jq -r '.[] | select(.is_focused) | .idx')
last=$(echo "$ws" | jq --arg o "$out" '[.[] | select(.output == $o and .active_window_id != null) | .idx] | max // empty')

if [ "$cur" -le 1 ] && [ -n "$last" ]; then
  niri msg action focus-workspace "$last"
else
  niri msg action focus-workspace-up
fi
