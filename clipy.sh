#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
source "$SCRIPT_DIR/lib/backend.sh"
source "$SCRIPT_DIR/lib/autopaste.sh"

items=$(cliphist list)
[ -z "$items" ] && exit 1

preview_cmd="$CLIPY_DIR/clipy-preview.sh {}"

chosen=$(echo "$items" | fzf \
  --prompt="$CLIPY_FZF_PROMPT" \
  --preview="$preview_cmd" \
  --preview-window="$CLIPMENU_FZF_PREVIEW_OPTS" \
  --bind='ctrl-d:execute(echo {} | cliphist delete)+reload(cliphist list)' \
  --header 'Ctrl-D: delete entry | Enter: copy')

[ -z "$chosen" ] && exit 0

echo "$chosen" | cliphist decode | wl-copy >/dev/null 2>&1
wl-paste -l >/dev/null

auto_paste
