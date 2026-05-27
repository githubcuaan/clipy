# clipmenu

Clipboard history picker for Wayland. Fuzzy search, image preview, auto-paste.

## Dependencies

**Required**
- `cliphist` — clipboard history backend
- `wl-clipboard` (wl-copy/wl-paste) — Wayland clipboard
- `fzf` — fuzzy finder UI
- `python3` — JSON parsing

**Optional**
- `wtype` — auto-paste after selection (enabled by default)
- `chafa` — image preview in fzf
- `bat` — syntax-highlighted text preview
- `kitty` — floating terminal overlay (default, configurable)

## Install

```sh
git clone https://github.com/YOUR_USER/clipmenu
cd clipmenu
./install.sh
```

Default prefix: `~/.local`. Override with `PREFIX=/usr ./install.sh`.

### Hyprland config (automatic)

```sh
./install.sh --install-config
```

Copies `examples/hyprland.conf` → `~/.config/hypr/clipmenu.conf`
and adds `source =` to `hyprland.conf`. Run `hyprctl reload` to apply.

### Uninstall

```sh
./uninstall.sh
```

Removes all installed files and reverts hyprland.conf changes.

## Usage

```
clipmenu            # toggle clipboard picker
clipmenu --version  # print version
```

## Configuration (env vars)

| Var | Default | Description |
|-----|---------|-------------|
| `CLIPMENU_TERMINAL` | `kitty` | Terminal for overlay |
| `CLIPMENU_WINDOW_CLASS` | `fuzzel` | Window class for toggle detection |
| `CLIPMENU_WINDOW_TITLE` | `Clipboard` | Window title for toggle detection |
| `CLIPMENU_MONITOR_RATIO` | `0.5` | Overlay window size ratio |
| `CLIPMENU_AUTOPASTE` | `true` | Auto-paste after selection |
| `CLIPMENU_AUTOPASTE_DELAY` | `0.5` | Seconds before paste |
| `CLIPMENU_FZF_PROMPT` | `clipboard > ` | fzf prompt |
| `CLIPMENU_FZF_PREVIEW_OPTS` | `right:65%:wrap:border-left` | fzf preview layout |
| `CLIPMENU_BACKEND` | `hyprland` | Backend (extensible) |

## Backends

Currently supports **Hyprland**. Extensible via `lib/backends/<name>.sh`.
Drop-in a new backend with `backend_monitor_size`, `backend_find_window`, and `backend_launch_terminal` functions.

## License

MIT
