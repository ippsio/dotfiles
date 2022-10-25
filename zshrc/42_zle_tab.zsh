# TAB(=CTRL+I)補完
function triggered_by_tab() {
  # Directory completion
  local -a cmds=("cd" "find")
  for c in $cmds; do
    [[ $BUFFER =~ "^${c} *$" ]] && BUFFER="${c} ./" && zle end-of-line # complete first './'.
    if [[ $BUFFER =~ "^${c} *.+/+$" ]]; then
      BUFFER="${c} $(fzf_list_dir ${${BUFFER#${c} }:-.} --PROMPT=${c})" && zle end-of-line
      return 0
    fi
  done

  # File name completion
  local -a cmds=("vim" "nvim" "source" "ls" "ll")
  for c in $cmds; do
    [[ $BUFFER =~ "^${c} *$" ]] && BUFFER="${c} ./" && zle end-of-line # complete first './'.
    if [[ $BUFFER =~ "^${c} *.+/+$" ]]; then
      BUFFER="${c} $(fzf_list_file ${${BUFFER#${c} }:-.} --PROMPT=${c})" && zle end-of-line
      return 0
    fi
  done

  if $(is_git_repo); then
    [[ $BUFFER =~ "^.*origin/+$" ]] \
      && RBUFFER="$(git branch --show-current)" && zle end-of-line && return
  fi


  # tig + completion
  [[ $BUFFER =~ '^tig +$' ]] \
  && zle autosuggest-clear \
  && BUFFER="tig $(git_branch_fzf| sed -e 's#^origin/##')" && zle end-of-line && return

  # 上記にヒットしなかたら、普通っぽい挙動にする
  zle expand-or-complete
}

