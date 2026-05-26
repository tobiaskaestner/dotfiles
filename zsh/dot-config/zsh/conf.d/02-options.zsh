HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE

setopt AUTO_CD
setopt NUMERIC_GLOB_SORT
unsetopt BEEP

# Completion behaviour
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
