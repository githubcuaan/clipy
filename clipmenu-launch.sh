#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
source "$SCRIPT_DIR/lib/backend.sh"

read -r w h <<< "$(backend_monitor_size)"
backend_launch_terminal "$CLIPMENU_DIR/clipmenu.sh" "$w" "$h"
