zle -N triggered_by_tab
bindkey "^I" triggered_by_tab

function triggered_by_tab() {
  ha=$(bufheadargs)

  isbuf "^$" && lbuf "cd ./"
  isbuf "cd[ ]*$" && lbuf "$ha ./"
  isbuf "ls[ ]*$" && lbuf "$ha ./"
  isbuf "ll[ ]*$" && lbuf "$ha ./"
  isbuf "vim[ ]*$" && lbuf "$ha ./"
  isbuf "nvim[ ]*$" && lbuf "$ha ./"
  isbuf "find[ ]*$" && lbuf "$ha ./"
  isbuf "source[ ]*$" && lbuf "$ha ./"
  if [[ $BUFFER =~ "^.*/$" ]]; then
    ha=$(bufheadargs)
    ta=$(buftailargs)
    isbuf "cd[ ]+.+$" && lbuf "$ha " && rbuf "fzf_list_dir $ta --PROMPT=$ha" && return 0
    isbuf "ls[ ]+.+$" && lbuf "$ha " && rbuf "fzf_list_file $ta --PROMPT=$ha" && return 0
    isbuf "ll[ ]+.+$" && lbuf "$ha " && rbuf "fzf_list_file $ta --PROMPT=$ha" && return 0
    isbuf "vim[ ]+.+$" && lbuf "$ha " && rbuf "fzf_list_file $ta --PROMPT=$ha" && return 0
    isbuf "nvim[ ]+.+$" && lbuf "$ha " && rbuf "fzf_list_file $ta --PROMPT=$ha" && return 0
    isbuf "find[ ]+.+$" && lbuf "$ha " && rbuf "fzf_list_dir  $ta --PROMPT=$ha" && return 0
    isbuf "source[ ]+.+$" && lbuf "$ha " && rbuf "fzf_list_file $ta --PROMPT=$ha" && return 0
  fi

  if $(is_git_repo); then
    isbuf "tig" && lbuf "$ha " && rbuf "git_branch_fzf" && return 0
    if [[ $BUFFER =~ "^.*origin/+$" ]]; then
      RBUFFER="$(git branch --show-current)"
      zle end-of-line
      return
    fi
  fi

  zle expand-or-complete
}
