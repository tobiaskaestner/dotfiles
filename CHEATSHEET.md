# Dotfiles Cheatsheet

## ZSH

### Key Bindings

| Key | Action |
|-----|--------|
| `ctrl-r` | fzf history search |
| `ctrl-t` | fzf file search (includes hidden files, bat preview) |
| `ctrl-f` | fzf file search (no hidden files, bat preview) |
| `alt-c` | fzf cd into subdirectory |
| `↑ / ↓` | History substring search — type partial command first, then navigate matches |
| `ctrl-→` | Move cursor forward one word |
| `ctrl-←` | Move cursor backward one word |
| `ctrl-\` | Toggle autosuggestions on/off |

### Aliases — File Listing

| Alias | Command |
|-------|---------|
| `ls` | `eza --icons` |
| `l` / `ll` | `eza -lh --git --icons` |
| `la` | `eza -lah --git --icons` (includes hidden) |
| `lt` | `eza --tree --icons` |

### Aliases — Core Utils

| Alias | Replaces | Notes |
|-------|----------|-------|
| `cat` | `bat` | Syntax-highlighted output |
| `grep` | `rg --color=auto` | ripgrep, respects .gitignore |
| `diff` | `diff --color=auto` | Colourised diff |
| `df` | `df -h` | Human-readable sizes |
| `du` | `dust` | Interactive disk usage |
| `top` | `btop` | Interactive system monitor |
| `vim` | `nvim` | Muscle memory fallback |
| `-` | `cd -` | Jump to previous directory |
| `cd <query>` | `z <query>` | Zoxide frecency jump |
| `cdi` | `zi` | Zoxide interactive directory picker (fzf) |

### Aliases — Git

| Alias | Command |
|-------|---------|
| `lg` | `lazygit` |
| `glog` | `git log` with non-clearing pager |
| `gadog` | `git log --all --decorate --oneline --graph` — full branch graph |

### Aliases — Neovim Profiles

| Alias | Profile |
|-------|---------|
| `lzv` | LazyVim (`NVIM_APPNAME=nvim-lazyvim`) |
| `asv` | AstroNvim (`NVIM_APPNAME=nvim-astro`) |
| `ksv` | Kickstart (`NVIM_APPNAME=nvim-kickstart`) |

### Aliases — Config

| Alias | Action |
|-------|--------|
| `zshconfig` | Open `~/.config/zsh` in nvim |
| `reload` | Re-source `~/.zshrc` and confirm |

### Custom Functions

#### `wbs` — Zephyr west build selector
Interactive fzf-powered selector for Zephyr builds. Run inside a west workspace.
1. Select a board from the full board/qualifier list
2. Select a sample from `zephyr/samples`
3. Constructed `west build` command is placed on the command line (not executed)

---

## Tmux

Prefix: **`ctrl-a`**

### Sessions

| Binding | Action |
|---------|--------|
| `prefix ctrl-a` | Send literal `ctrl-a` to the running program |
| `prefix $` | Rename session |
| `prefix d` | Detach from session |
| `prefix g` | Open **lazygit** in a floating popup |

### Session Persistence (tmux-resurrect / tmux-continuum)

| Binding | Action |
|---------|--------|
| `prefix ctrl-s` | Save session manually |
| `prefix ctrl-r` | Restore session manually |

Auto-saves every 15 minutes. Auto-restores on tmux server start.

### Windows

| Binding | Action |
|---------|--------|
| `prefix c` | New window (inherits current path) |
| `prefix h` | Previous window |
| `prefix l` | Next window |
| `prefix Space` | Jump to last active window (toggle) |
| `prefix <` | Move window left |
| `prefix >` | Move window right |
| `prefix ,` | Rename window |
| `prefix b` | Break current pane into its own window |
| `prefix r` | Reload tmux config |

### Panes

| Binding | Action |
|---------|--------|
| `prefix \|` | Split vertically (side-by-side) |
| `prefix -` | Split horizontally (top/bottom) |
| `ctrl-h/j/k/l` | Navigate panes (or Neovim splits — no prefix needed) |
| `prefix H/J/K/L` | Resize pane in 5-cell steps (repeatable) |
| `prefix x` | Kill pane |

### Copy Mode (vi keys)

| Binding | Action |
|---------|--------|
| `prefix v` | Enter copy mode |
| `v` | Begin character-wise selection |
| `V` | Begin line-wise selection |
| `ctrl-v` | Toggle rectangle/block selection |
| `y` | Yank selection to clipboard and exit |
| `ctrl-h/j/k/l` | Navigate panes without leaving copy mode |
