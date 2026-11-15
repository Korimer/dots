#!/bin/sh
ws=$(niri msg -j workspaces)
out=$(echo "$ws" | jq -r '.[] | select(.is_focused) | .output')
cur=$(echo "$ws" | jq -r '.[] | select(.is_focused) | .idx')
max=$(echo "$ws" | jq --arg o "$out" '[.[] | select(.output == $o) | .idx] | max')

if [ "$cur" -ge "$max" ]; then
    niri msg action focus-workspace 1
else
    niri msg action focus-workspace-down
fi
