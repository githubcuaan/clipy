# clipy

<p align="center">
  <img src="docs/clipylogo.png" alt="clipy logo" width="200">
</p>

<p align="center">
 <a href="#install">Install</a> · <a href="#usage">Usage</a> · <a href="#configuration-env-vars">Config</a> · <a href="#backends">Backends</a> · <a href="#license">License</a>
</p>

Clipboard history picker for Wayland. Fuzzy search, image preview, auto-paste.
**Note**: We **ONLY support Hyprland** for now, but the backend is designed to be extensible. Contributions welcome!

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
git clone https://github.com/YOUR_USER/clipy
cd clipy
./install.sh
```

Default prefix: `~/.local`. Override with `PREFIX=/usr ./install.sh`.

### Hyprland config (automatic)

```sh
./install.sh --install-config
```

Copies `examples/hyprland.conf` → `~/.config/hypr/clipy.conf`
and adds `source =` to `hyprland.conf`. Run `hyprctl reload` to apply.

### Uninstall

```sh
./uninstall.sh
```

Removes all installed files and reverts hyprland.conf changes.

## Usage

```
clipy            # toggle clipboard picker
clipy --version  # print version
```

## Configuration (env vars)

| Var                         | Default                      | Description                       |
| --------------------------- | ---------------------------- | --------------------------------- |
| `CLIPY_TERMINAL`         | `kitty`                      | Terminal for overlay              |
| `CLIPY_WINDOW_CLASS`     | `fuzzel`                     | Window class for toggle detection |
| `CLIPY_WINDOW_TITLE`     | `Clipboard`                  | Window title for toggle detection |
| `CLIPY_MONITOR_RATIO`    | `0.5`                        | Overlay window size ratio         |
| `CLIPY_AUTOPASTE`        | `true`                       | Auto-paste after selection        |
| `CLIPY_AUTOPASTE_DELAY`  | `0.5`                        | Seconds before paste              |
| `CLIPY_FZF_PROMPT`       | `clipboard > `               | fzf prompt                        |
| `CLIPY_FZF_PREVIEW_OPTS` | `right:65%:wrap:border-left` | fzf preview layout                |
| `CLIPY_BACKEND`          | `hyprland`                   | Backend (extensible)              |

## Backends

Currently supports **Hyprland**. Extensible via `lib/backends/<name>.sh`.
Drop-in a new backend with `backend_monitor_size`, `backend_find_window`, and `backend_launch_terminal` functions.

## License

MIT
