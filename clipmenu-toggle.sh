#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
source "$SCRIPT_DIR/lib/backend.sh"

case "${1:-}" in
  --version|-v)
    echo "clipmenu $CLIPMENU_VERSION"
    exit 0
    ;;
esac

pid=$(backend_find_window)

if [ -n "$pid" ]; then
  kill -9 "$pid"
else
  exec "$CLIPMENU_DIR/clipmenu-launch.sh"
fi
