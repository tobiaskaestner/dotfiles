# Must load LAST: zoxide's own docs require this, since __zoxide_hook is
# appended to chpwd_functions at init time — anything sourced afterward that
# reassigns (rather than appends to) chpwd_functions/precmd_functions would
# silently drop it. Previously this was in 03-env.zsh, ahead of
# 04-aliases/05-functions/06-keybindings/09-syntax-highlighting, which is what
# the "zoxide: detected a possible configuration issue" warning was about.
eval "$(zoxide init zsh --cmd cd)"
