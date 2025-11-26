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
    isbuf "cd[ ]+.+$" && rbuf_val=$(rbufval "fzf_list_dir $ta --PROMPT=$ha") && lbuf "$ha" && rbuf " $rbuf_val" && return 0
    isbuf "ls[ ]+.+$" && rbuf_val=$(rbufval "fzf_list_file $ta --PROMPT=$ha") && lbuf "$ha" && rbuf " $rbuf_val" && return 0
    isbuf "ll[ ]+.+$" && rbuf_val=$(rbufval "fzf_list_file $ta --PROMPT=$ha") && lbuf "$ha" && rbuf " $rbuf_val" && return 0
    isbuf "vim[ ]+.+$" && rbuf_val=$(rbufval "fzf_list_file $ta --PROMPT=$ha") && lbuf "$ha" && rbuf " $rbuf_val" && return 0
    isbuf "nvim[ ]+.+$" && rbuf_val=$(rbufval "fzf_list_file $ta --PROMPT=$ha") && lbuf "$ha" && rbuf " $rbuf_val" && return 0
    isbuf "find[ ]+.+$" && rbuf_val=$(rbufval "fzf_list_dir  $ta --PROMPT=$ha") && lbuf "$ha" && rbuf " $rbuf_val" && return 0
    isbuf "source[ ]+.+$" && rbuf_val=$(rbufval "fzf_list_file $ta --PROMPT=$ha") && lbuf "$ha" && rbuf " $rbuf_val" && return 0
  fi

  if $(is_git_repo); then
    isbuf "tig" && rbuf_val=$(rbufval "git_branch_fzf") && lbuf "$ha" && rbuf " $rbuf_val" && return 0
    if [[ $BUFFER =~ "^.*origin/+$" ]]; then
      RBUFFER="$(git branch --show-current)"
      zle end-of-line
      return
    fi
  fi

  zle expand-or-complete
}
