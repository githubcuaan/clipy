#!/usr/bin/env bash
set -euo pipefail

PREFIX="${PREFIX:-$HOME/.local}"
SHARE_DIR="$PREFIX/share/clipmenu"
BIN_DIR="$PREFIX/bin"
HYPR_DIR="$HOME/.config/hypr"
HYPR_CONF="$HYPR_DIR/hyprland.conf"
CLIPMENU_CONF="$HYPR_DIR/clipmenu.conf"

echo "=== Uninstalling clipmenu ==="

removed_any=false

if [ -L "$BIN_DIR/clipmenu" ]; then
  rm -v "$BIN_DIR/clipmenu"
  removed_any=true
fi

if [ -d "$SHARE_DIR" ]; then
  rm -rfv "$SHARE_DIR"
  removed_any=true
fi

if [ -f "$CLIPMENU_CONF" ]; then
  rm -v "$CLIPMENU_CONF"
  removed_any=true
fi

if [ -f "$HYPR_CONF" ]; then
  if grep -q 'clipmenu\.conf' "$HYPR_CONF" || grep -q '^# clipmenu$' "$HYPR_CONF"; then
    sed -i '/clipmenu\.conf/d' "$HYPR_CONF"
    sed -i '/^# clipmenu$/d' "$HYPR_CONF"
    echo "Removed clipmenu config lines from $HYPR_CONF"
    removed_any=true
  fi
fi

if [ "$removed_any" = false ]; then
  echo "Nothing to uninstall."
else
  echo ""
  echo "clipmenu uninstalled."
fi
