#!/usr/bin/env bash
set -euo pipefail

layouts=(tile scroller deck)
direction="${1:-next}"

current_symbol="$(mmsg get all-monitors | jq -r '.monitors[] | select(.active) | .layout_symbol')"

case "$current_symbol" in
    T) idx=0 ;;
    S) idx=1 ;;
    K) idx=2 ;;
    *) idx=-1 ;;
esac

count=${#layouts[@]}

if [[ "$direction" == "prev" ]]; then
    next_idx=$(( (idx - 1 + count) % count ))
    [[ $idx -eq -1 ]] && next_idx=$(( count - 1 ))
else
    next_idx=$(( (idx + 1) % count ))
fi

exec mmsg dispatch "setlayout,${layouts[$next_idx]}"
