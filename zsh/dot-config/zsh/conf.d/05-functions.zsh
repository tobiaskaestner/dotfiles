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
