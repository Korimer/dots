#!/bin/sh
win=$(niri msg -j focused-window)
col=$(echo "$win" | jq '.layout.pos_in_scrolling_layout[0] // empty')
[ -z "$col" ] && exit 0

if [ "$col" -le 1 ]; then
  niri msg action focus-column-last
else
  niri msg action focus-column-left
fi
