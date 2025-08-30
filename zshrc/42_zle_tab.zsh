zle -N triggered_by_tab
bindkey "^I" triggered_by_tab

# TAB(=CTRL+I)補完
function triggered_by_tab() {
  # Directory completion
  if [[ -z "$BUFFER" ]]; then
    dir=$(fzf_list_dir)
    if [[ -n "$dir" ]]; then
      LBUFFER="cd $dir"
      zle end-of-line
      return 0
    else
      BUFFER=""
      zle end-of-line
      return 0
    fi
  else
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
        fzf_response=$(fzf_list_file ${${BUFFER#${c} }:-.} --PROMPT=${c})
        if [[ -n "${fzf_response}" ]]; then
          BUFFER="${c} ${fzf_response}" && zle end-of-line
        fi
        return 0
      fi
    done

    if $(is_git_repo); then
      if [[ $BUFFER =~ "^.*origin/+$" ]]; then
        RBUFFER="$(git branch --show-current)"
        zle end-of-line
        return
      fi
    fi

    # tig + completion
    [[ $BUFFER =~ '^tig +$' ]] \
    && zle autosuggest-clear \
    && BUFFER="tig $(git_branch_fzf| sed -e 's#^origin/##')" && zle end-of-line && return
  fi

  # 上記にヒットしなかたら、普通っぽい挙動にする
  zle expand-or-complete
}

