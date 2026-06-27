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
| starship | `~/.config/starship.toml` |
| stow | `~/.stowrc` |
| tmux | `~/.config/tmux/` |
| yazi | `~/.config/yazi/` |
| zsh | `~/.zshrc`, `~/.zshenv`, `~/.config/zsh/` |

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
stow alacritty bash ghostty git jj kitty lazygit mc starship tmux yazi zsh
```

Stow will create symlinks from `~` into the repo. If a target file already exists and is not a symlink, stow will error — remove or back up the conflicting file first.

## Moving an existing config into this repo

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

## Adding a new package

Follow the same structure as existing packages. Files that belong in `~/.config/<tool>/` go under `<package>/dot-config/<tool>/`. Files that belong directly in `~` are named with a `dot-` prefix (e.g. `dot-zshrc` → `~/.zshrc`).

## Packages with special structure

**zsh** splits configuration across multiple files instead of a single `.zshrc`:

```
zsh/
  dot-zshrc                        # entry point — sources conf.d/*.zsh in order
  dot-zshenv                       # env vars for all zsh instances (e.g. ZDOTDIR)
  dot-config/zsh/conf.d/
    01-plugins.zsh                 # plugins and completions (compinit)
    02-options.zsh                 # setopt and zstyle
    03-env.zsh                     # PATH, tool hooks (direnv, starship, fzf, zoxide)
    04-aliases.zsh                 # aliases
    05-functions.zsh               # shell functions (theme, vcsmode, wbs, y, …)
    06-keybindings.zsh             # ZLE widgets and bindkey calls
    09-syntax-highlighting.zsh     # zsh-syntax-highlighting (must load last)
```

Add new topic-specific config by dropping a numbered `.zsh` file into `conf.d/` — it will be sourced automatically on the next shell start.

`~/.zsh/completions/` is also part of this package and is added to `fpath` in `01-plugins.zsh`. Drop new completion scripts there.

## Notes

- Package directories use `dot-` instead of `.` (e.g. `dot-config` → `.config`). This requires passing `--dotfiles` to stow.
- Stow is run from `~/dotfiles` and targets `~` by default.
- To remove symlinks: `stow --dotfiles -D <package>`
- To check what stow would do without making changes: `stow --dotfiles --simulate <package>`
