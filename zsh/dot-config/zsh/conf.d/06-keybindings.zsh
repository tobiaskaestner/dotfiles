# ctrl-r  — fzf history search        (from fzf --zsh)
# ctrl-t  — fzf file search           (from fzf --zsh)
# alt-c   — fzf cd into dir           (from fzf --zsh)

# fzf file picker (no hidden files)
bindkey '^F' _fzf_file_no_hidden

# word movement
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# toggle autosuggestions
bindkey '^\' autosuggest-toggle

# history substring search (type partial command, then use ↑/↓)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
