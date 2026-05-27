#!/usr/bin/env bash
line="$1"

printf '\033_Ga=d\033\\'

t=$(mktemp)
echo "$line" | cliphist decode 2>/dev/null > "$t"
if file "$t" | grep -qi "image"; then
  c=${FZF_PREVIEW_COLUMNS:-72}
  l=${FZF_PREVIEW_LINES:-36}
  chafa -f kitty -s ${c}x${l} "$t" 2>/dev/null
else
  head -c 2000 "$t" | bat --theme="Catppuccin Frappe" --color=always -n 2>/dev/null
fi
rm -f "$t"
