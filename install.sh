#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
PREFIX="${PREFIX:-$HOME/.local}"
SHARE_DIR="$PREFIX/share/clipmenu"
BIN_DIR="$PREFIX/bin"

install_clipmenu() {
  mkdir -p "$SHARE_DIR/lib/backends" "$BIN_DIR"

  cp "$SCRIPT_DIR/clipmenu.sh" "$SCRIPT_DIR/clipmenu-preview.sh" \
     "$SCRIPT_DIR/clipmenu-launch.sh" "$SCRIPT_DIR/clipmenu-toggle.sh" "$SHARE_DIR/"
  cp -r "$SCRIPT_DIR/lib/"* "$SHARE_DIR/lib/"
  ln -sf "$SHARE_DIR/clipmenu-toggle.sh" "$BIN_DIR/clipmenu"

  echo "Installed to $SHARE_DIR"
  echo "Symlink: $BIN_DIR/clipmenu -> $SHARE_DIR/clipmenu-toggle.sh"
  echo ""
  echo "Make sure $BIN_DIR is in your PATH."
  echo "Set keybind: exec $BIN_DIR/clipmenu"
}

install_config() {
  local hypr_dir="$HOME/.config/hypr"
  local hypr_conf="$hypr_dir/hyprland.conf"
  local clipmenu_conf="$hypr_dir/clipmenu.conf"
  local example_conf="$SCRIPT_DIR/examples/hyprland.conf"

  if [ ! -f "$example_conf" ]; then
    echo "Error: $example_conf not found" >&2
    exit 1
  fi

  mkdir -p "$hypr_dir"
  cp "$example_conf" "$clipmenu_conf"
  echo "Copied config → $clipmenu_conf"

  if [ ! -f "$hypr_conf" ]; then
    echo "Warning: $hypr_conf not found. Skipping source injection." >&2
    return
  fi

  if grep -q 'source.*clipmenu\.conf' "$hypr_conf"; then
    echo "Source line already present in $hypr_conf. Skipping."
    return
  fi

  cat >> "$hypr_conf" <<'EOF'

# clipmenu
source = ~/.config/hypr/clipmenu.conf
EOF
  echo "Added 'source = ~/.config/hypr/clipmenu.conf' → $hypr_conf"
  echo "Run 'hyprctl reload' to apply."
}

case "${1:-}" in
  --install-config)
    install_clipmenu
    echo ""
    install_config
    ;;
  *)
    install_clipmenu
    ;;
esac
