_fzf_file_no_hidden() {
  local cmd result
  cmd="${FZF_DEFAULT_COMMAND/--hidden /}"
  result=$(eval "${cmd:-find . -type f}" | fzf --preview "$_FZF_PREVIEW_CMD") \
    && LBUFFER+="$result"
  zle reset-prompt
}
zle -N _fzf_file_no_hidden

theme() {
  local flavor="${1:-toggle}"
  local current
  current=$(cat "$HOME/.config/current-theme" 2>/dev/null || echo "mocha")

  [[ "$flavor" == "toggle" ]] && flavor=$([[ "$current" == "mocha" ]] && echo "latte" || echo "mocha")

  case "$flavor" in
    mocha|dark)  flavor="mocha" ;;
    latte|light) flavor="latte" ;;
    *)
      print "Usage: theme [mocha|dark|latte|light|toggle]  (current: $current)"
      return 1
      ;;
  esac

  echo "$flavor" > "$HOME/.config/current-theme"

  # tmux
  printf 'set -gq @catppuccin_flavor "%s"\n' "$flavor" > "$HOME/.config/tmux/theme.conf"
  [[ -n "$TMUX" ]] && tmux source "$HOME/.config/tmux/tmux.conf"

  # kitty — copy pre-extracted theme file and reload via SIGUSR1
  cp "$HOME/.config/kitty/catppuccin-${flavor}.conf" "$HOME/.config/kitty/current-theme.conf"
  pkill -USR1 kitty 2>/dev/null

  print "Switched to $flavor"
}

wbs() {
  local zephyr_base=$(west topdir 2>/dev/null)/zephyr
  if [[ ! -d "$zephyr_base" ]]; then
    echo "Error: Not in a west workspace."
    return 1
  fi

  local -a board_list raw_output
  raw_output=( ${(f)"$(west boards --format='{name}/{qualifiers}')"} )

  for line in $raw_output; do
    local b_name=${line%%/*}
    local all_quals=${line#*/}
    local -a q_array=(${(s/,/)all_quals})

    for q in $q_array; do
      if [[ "$q" == "$b_name"/* ]]; then
        board_list+=("$q")
      else
        board_list+=("$b_name/$q")
      fi
    done
  done

  local selected_board=$(printf "%s\n" "${board_list[@]}" | fzf --height 40% --reverse --prompt="1. Board > ")
  [[ -z "$selected_board" ]] && return 1

  local sample_path=$(rg -l "find_package\(Zephyr" "$zephyr_base/samples" -g "CMakeLists.txt" | \
                      xargs -n1 dirname | \
                      sed "s|$zephyr_base/||" | \
                      fzf --height 40% --reverse --prompt="2. Sample > ")
  [[ -z "$sample_path" ]] && return 1

  local cmd="west build -p auto -b $selected_board $zephyr_base/$sample_path"
  echo "Constructed: $cmd"
  print -z "$cmd"
}
