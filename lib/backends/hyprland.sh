backend_monitor_size() {
  hyprctl monitors -j | python3 -c "
import json, sys
m = json.load(sys.stdin)[0]
ratio = float('${CLIPY_MONITOR_RATIO:-0.5}')
print(int(m['width'] * ratio), int(m['height'] * ratio))
"
}

backend_find_window() {
  local class="${1:-${CLIPY_WINDOW_CLASS:-fuzzel}}"
  local title="${2:-${CLIPY_WINDOW_TITLE:-Clipboard}}"
  hyprctl clients -j | python3 -c "
import json, sys
for w in json.load(sys.stdin):
    if w.get('class') == '$class' and w.get('title') == '$title':
        print(w['pid'])
        break
"
}

backend_launch_terminal() {
  local cmd="$1"
  local w="$2"
  local h="$3"
  exec kitty --class fuzzel --title "Clipboard" \
    -o remember_window_size=no \
    -o initial_window_width="$w" \
    -o initial_window_height="$h" \
    "$cmd"
}
