# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow package that mirrors the home directory structure, using the `dot-` prefix convention in place of a leading `.`.

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

### Notes

- Package directories use `dot-` instead of `.` (e.g. `dot-config` → `.config`). This requires passing `--dotfiles` to stow.
- Stow is run from `~/dotfiles` and targets `~` by default.
- To remove symlinks: `stow --dotfiles -D <package>`
- To check what stow would do without making changes: `stow --dotfiles --simulate <package>`
