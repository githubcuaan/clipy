#!/usr/bin/env bash

auto_paste() {
  if [ "$CLIPY_AUTOPASTE" != true ]; then
    return 0
  fi

  local active_class=$(hyprctl activewindow -j | grep -o '"class": "[^"]*"' | cut -d'"' -f4)

  hyprctl dispatch exec "sleep $CLIPY_AUTOPASTE_DELAY && wtype -M ctrl -M shift v -m shift -m ctrl"
}
