# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). 
Each top-level directory is a stow package that mirrors the home directory structure, using the `dot-` prefix convention in place of a leading `.`.

## Packages

| Package | Config location |
|---------|----------------|
| alacritty | `~/.config/alacritty/` |
| bash | `~/.bashrc` etc. |
| ghostty | `~/.config/ghostty/` |
| git | `~/.gitconfig` etc. |
| jj | `~/.config/jj/` |
| kitty | `~/.config/kitty/` |
| lazygit | `~/.config/lazygit/` |
| mc | `~/.config/mc/` |
| tmux | `~/.config/tmux/` |
| yazi | `~/.config/yazi/` |
| zsh | `~/.zshrc`, `~/.zshenv`, `~/.config/zsh/` |

## A) Apply configs on a new machine

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
stow --dotfiles <package>
# or apply all at once:
for pkg in */; do stow --dotfiles "${pkg%/}"; done
```

Stow will create symlinks from `~` into the repo. If a target file already exists and is not a symlink, stow will error — remove or back up the conflicting file first.

## B) Move an existing config into this repo

### Directory (preferred — symlinks the whole folder)

```bash
cd ~/dotfiles
mkdir -p <package>/dot-config/<app>
cp -r ~/.config/<app>/. <package>/dot-config/<app>/
rm -rf ~/.config/<app>
stow --dotfiles <package>
```

### Single file

```bash
cd ~/dotfiles
mkdir -p <package>/dot-config/<app>
cp ~/.config/<app>/<file> <package>/dot-config/<app>/<file>
rm ~/.config/<app>/<file>
stow --dotfiles <package>
```

### Runtime-generated files to exclude

If the app writes files into its config directory that you don't want tracked (plugin dirs, caches, per-machine state), add them to `.gitignore` before stowing:

```
# .gitignore
<package>/dot-config/<app>/<generated-dir>/
```

Then stow as normal — git will ignore those paths even though they live inside the repo directory via the symlink.

### Packages with special structure

**zsh** splits configuration across multiple files instead of a single `.zshrc`:

```
zsh/
  dot-zshrc                        # entry point — sources conf.d/*.zsh in order
  dot-zshenv                       # env vars for all zsh instances (e.g. cargo)
  dot-config/zsh/conf.d/
    01-plugins.zsh                 # oh-my-zsh setup
    02-env.zsh                     # PATH and tool hooks (direnv etc.)
    03-aliases.zsh                 # aliases
    04-functions.zsh               # shell functions
    05-keybindings.zsh             # ZLE widgets and bindkey calls
```

Add new topic-specific config by dropping a numbered `.zsh` file into `conf.d/` — it will be sourced automatically on the next shell start.

`~/.zsh/completions/` is also part of this package and is added to `fpath` in `01-plugins.zsh`. Drop new completion scripts there.

**Prerequisite:** oh-my-zsh must be installed separately — it is not tracked in this repo:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Notes

- Package directories use `dot-` instead of `.` (e.g. `dot-config` → `.config`). This requires passing `--dotfiles` to stow.
- Stow is run from `~/dotfiles` and targets `~` by default.
- To remove symlinks: `stow --dotfiles -D <package>`
- To check what stow would do without making changes: `stow --dotfiles --simulate <package>`

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

| Package | Config for |
|---|---|
| `stow` | GNU Stow (`.stowrc`) |
| `git` | Git |
| `mc` | Midnight Commander |
| `tmux` | tmux |
| `yazi` | yazi file manager |

## Bootstrapping a new machine

### 1. Clone the repo

```bash
git clone git@github.com:tobiaskaestner/dotfiles.git ~/dotfiles
```

### 2. Stow the `stow` package first

This is the only time you need to pass flags manually, since `~/.stowrc` doesn't exist yet:

```bash
cd ~/dotfiles && stow --dotfiles -t ~ stow
```

This creates `~/.stowrc`, which configures all subsequent `stow` invocations to automatically use `--dotfiles` and target `~`.

### 3. Stow the remaining packages

```bash
stow git mc tmux yazi
```

## Adding a new package

Follow the same structure as existing packages. Files that belong in `~/.config/<tool>/` go under `<package>/dot-config/<tool>/`. Files that belong directly in `~` are named with a `dot-` prefix (e.g. `dot-zshrc` → `~/.zshrc`).
>>>>>>> 820071f (docs: add chapters on using stow and bootstrapping a new machine)
