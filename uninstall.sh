#!/usr/bin/env bash
set -euo pipefail

PREFIX="${PREFIX:-$HOME/.local}"
SHARE_DIR="$PREFIX/share/clipy"
BIN_DIR="$PREFIX/bin"
HYPR_DIR="$HOME/.config/hypr"
HYPR_CONF="$HYPR_DIR/hyprland.conf"
CLIPY_CONF="$HYPR_DIR/clipy.conf"

echo "=== Uninstalling clipy ==="

removed_any=false

if [ -L "$BIN_DIR/clipy" ]; then
  rm -v "$BIN_DIR/clipy"
  removed_any=true
fi

if [ -d "$SHARE_DIR" ]; then
  rm -rfv "$SHARE_DIR"
  removed_any=true
fi

if [ -f "$CLIPY_CONF" ]; then
  rm -v "$CLIPY_CONF"
  removed_any=true
fi

if [ -f "$HYPR_CONF" ]; then
  if grep -q 'clipy\.conf' "$HYPR_CONF" || grep -q '^# clipy$' "$HYPR_CONF"; then
    sed -i '/clipy\.conf/d' "$HYPR_CONF"
    sed -i '/^# clipy$/d' "$HYPR_CONF"
    echo "Removed clipy config lines from $HYPR_CONF"
    removed_any=true
  fi
fi

if [ "$removed_any" = false ]; then
  echo "Nothing to uninstall."
else
  echo ""
  echo "clipy uninstalled."
fi
