# eza (ls replacement)
alias ls='eza --icons'
alias l='eza -lh --git --icons'
alias ll='eza -lh --git --icons'
alias la='eza -lah --git --icons'
alias lt='eza --tree --icons'
compdef eza=ls

# bat (cat replacement)
alias cat='bat'

# core utils
alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'
alias du='dust'

# system
alias top='btop'
alias vim='nvim'

# navigation
alias -- -='cd -'

# git
alias lg='lazygit'
alias glog='PAGER="less -F -X" git log'
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'

# config shortcuts
alias zshconfig='nvim ~/.config/zsh'

# neovim profiles
alias lzv='NVIM_APPNAME=nvim-lazyvim nvim'
alias asv='NVIM_APPNAME=nvim-astro nvim'
alias ksv='NVIM_APPNAME=nvim-kickstart nvim'
