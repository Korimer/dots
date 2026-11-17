#!/bin/sh
win=$(niri msg -j focused-window)
ws=$(echo "$win" | jq '.workspace_id')
col=$(echo "$win" | jq '.layout.pos_in_scrolling_layout[0] // empty')
[ -z "$col" ] && exit 0
max=$(niri msg -j windows | jq --argjson w "$ws" \
  '[.[] | select(.workspace_id == $w) | .layout.pos_in_scrolling_layout[0] // 0] | max')

if [ "$col" -ge "$max" ]; then
  niri msg action focus-column-first
else
  niri msg action focus-column-right
fi
