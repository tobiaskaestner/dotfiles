# jj (jujutsu) completion.
#
# `jj util completion zsh` is static: subcommands and flags only. `COMPLETE=zsh jj`
# emits clap's dynamic completer, which queries the repo for bookmark names,
# revsets, tags, operation ids and aliases. Cached because it spawns jj on every
# shell start; regenerated automatically when the binary is newer than the cache.
# The cache dir is created by 01-plugins.zsh, which sources first.
if (( $+commands[jj] )); then
  _jj_comp="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/jj-completion.zsh"
  if [[ ! -s $_jj_comp || $commands[jj] -nt $_jj_comp ]]; then
    COMPLETE=zsh jj >| $_jj_comp
  fi
  source $_jj_comp
  unset _jj_comp
fi
