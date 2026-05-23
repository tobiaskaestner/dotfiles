# yazi

Config for [yazi](https://github.com/sxyazi/yazi), a blazing fast terminal file manager.

## Files

| File | Purpose |
|---|---|
| `dot-config/yazi/yazi.toml` | Manager, preview, openers, plugins, input dialogs |
| `dot-config/yazi/keymap.toml` | Full vim-like keybindings for all UI contexts |
| `dot-config/yazi/theme.toml` | Dark theme with 500+ file type icons |
| `dot-config/yazi/vfs.toml` | Virtual filesystem services |

These are the upstream defaults from the [`shipped` branch](https://github.com/sxyazi/yazi/tree/shipped/yazi-config/preset), captured as an explicit baseline to make customisation easier.

## Deployment

```bash
cd ~/dotfiles && stow -t ~ yazi
```

This symlinks `dot-config/yazi/` into `~/.config/yazi/`.

## Optional dependencies

The following packages must be installed to get the full experience (previews, search, navigation):

| Package | Purpose |
|---|---|
| `ffmpeg` | Video thumbnails |
| `poppler` | PDF preview |
| `resvg` | SVG preview |
| `imagemagick` | Image and font preview |
| `fd` | File search (`s` key) |
| `ripgrep` | Content search (`S` key) |
| `fzf` | Fuzzy jump to file/directory (`z` key) |
| `zoxide` | Historical directory navigation (`Z` key) |
| `7zip` | Archive extraction and preview |
| `jq` | JSON preview |
| `wl-clipboard` | Wayland clipboard support (use `xclip` or `xsel` on X11) |
| `git` | Yazi package manager (`ya pkg`) |
