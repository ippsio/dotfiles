# TAB(=CTRL+I)補完
function triggered_by_tab() {
  # Directory completion
  local -a cmds=("cd" "find")
  for c in $cmds; do
    [[ $BUFFER =~ "^${c} *$" ]] && BUFFER="${c} ./" && zle end-of-line # complete first './'.
    [[ $BUFFER =~ "^${c} *.+/+$" ]] && BUFFER="${c} $(fzf_list_dir ${${BUFFER#${c} }:-.} --PROMPT=${c})" && zle end-of-line && return
  done

  # File name completion
  local -a cmds=("vim" "nvim" "source" "ls" "ll")
  for c in $cmds; do
    [[ $BUFFER =~ "^${c} *$" ]] && BUFFER="${c} ./" && zle end-of-line # complete first './'.
    [[ $BUFFER =~ "^${c} *.+/+$" ]] && BUFFER="${c} $(fzf_list_file ${${BUFFER#${c} }:-.} --PROMPT=${c})" && zle end-of-line && return
  done

  # 上記にヒットしなかたら、普通っぽい挙動にする
  zle expand-or-complete
}

