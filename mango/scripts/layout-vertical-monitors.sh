#!/usr/bin/env bash
# vertical-monitors.sh: set every portrait monitor to vertical_scroller,
# then return focus to the originally focused monitor.
set -euo pipefail

monitors="$(mmsg get all-monitors)"
original="$(jq -r '.monitors[] | select(.active) | .name' <<< "$monitors")"

while IFS= read -r output; do
    mmsg dispatch "focusmon,$output" >/dev/null
    mmsg dispatch "setlayout,vertical_scroller" >/dev/null
done < <(jq -r '.monitors[] | select(.height > .width) | .name' <<< "$monitors")

mmsg dispatch "focusmon,$original" >/dev/null
