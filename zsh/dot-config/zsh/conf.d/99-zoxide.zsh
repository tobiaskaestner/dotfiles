# Must load LAST: zoxide's own docs require this, since __zoxide_hook is
# appended to chpwd_functions at init time — anything sourced afterward that
# reassigns (rather than appends to) chpwd_functions/precmd_functions would
# silently drop it. Previously this was in 03-env.zsh, ahead of
# 04-aliases/05-functions/06-keybindings/09-syntax-highlighting, which is what
# the "zoxide: detected a possible configuration issue" warning was about.
#
# Skipped under Claude Code (CLAUDECODE=1): its shell snapshot captures the
# zoxide functions but not the chpwd_functions array, so every `cd` in the
# agent's shell tripped __zoxide_doctor. Agents don't need frecency jumps
# (and shouldn't pollute the zoxide db), so plain builtin cd is fine there.
[[ -n $CLAUDECODE ]] || eval "$(zoxide init zsh --cmd cd)"
