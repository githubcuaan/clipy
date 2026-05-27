#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
PREFIX="${PREFIX:-$HOME/.local}"
SHARE_DIR="$PREFIX/share/clipy"
BIN_DIR="$PREFIX/bin"

install_clipy() {
  mkdir -p "$SHARE_DIR/lib/backends" "$BIN_DIR"

  cp "$SCRIPT_DIR/src/clipy.sh" "$SCRIPT_DIR/src/clipy-preview.sh" \
     "$SCRIPT_DIR/src/clipy-launch.sh" "$SCRIPT_DIR/src/clipy-toggle.sh" \
     "$SCRIPT_DIR/src/backend.sh" "$SCRIPT_DIR/src/autopaste.sh" "$SHARE_DIR/"
  cp -r "$SCRIPT_DIR/src/backends" "$SHARE_DIR/"
  ln -sf "$SHARE_DIR/clipy-toggle.sh" "$BIN_DIR/clipy"

  echo "Installed to $SHARE_DIR"
  echo "Symlink: $BIN_DIR/clipy -> $SHARE_DIR/clipy-toggle.sh"
  echo ""
  echo "Make sure $BIN_DIR is in your PATH."
  echo "Set keybind: exec $BIN_DIR/clipy"
}

install_config() {
  local hypr_dir="$HOME/.config/hypr"
  local hypr_conf="$hypr_dir/hyprland.conf"
  local clipy_conf="$hypr_dir/clipy.conf"
  local example_conf="$SCRIPT_DIR/examples/hyprland.conf"

  if [ ! -f "$example_conf" ]; then
    echo "Error: $example_conf not found" >&2
    exit 1
  fi

  mkdir -p "$hypr_dir"
  cp "$example_conf" "$clipy_conf"
  echo "Copied config → $clipy_conf"

  if [ ! -f "$hypr_conf" ]; then
    echo "Warning: $hypr_conf not found. Skipping source injection." >&2
    return
  fi

  if grep -q 'source.*clipy\.conf' "$hypr_conf"; then
    echo "Source line already present in $hypr_conf. Skipping."
    return
  fi

  cat >> "$hypr_conf" <<'EOF'

# clipy
source = ~/.config/hypr/clipy.conf
EOF
  echo "Added 'source = ~/.config/hypr/clipy.conf' → $hypr_conf"
  echo "Run 'hyprctl reload' to apply."
}

case "${1:-}" in
  --install-config)
    install_clipy
    echo ""
    install_config
    ;;
  *)
    install_clipy
    ;;
esac
