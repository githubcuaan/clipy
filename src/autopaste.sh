#!/usr/bin/env bash

auto_paste() {
  if [ "$CLIPY_AUTOPASTE" != true ]; then
    return 0
  fi

  hyprctl dispatch exec "sleep $CLIPY_AUTOPASTE_DELAY && wtype -M ctrl -M shift v -m shift -m ctrl"
}
