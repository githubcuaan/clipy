#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
source "$SCRIPT_DIR/backend.sh"

read -r w h <<< "$(backend_monitor_size)"
backend_launch_terminal "$CLIPY_DIR/clipy.sh" "$w" "$h"
