zle -N triggered_by_tab
bindkey "^I" triggered_by_tab

function triggered_by_tab() {
  ha=$(bufheadargs)

  lbuf_subtract "^$" "cd ./"
  lbuf_subtract "cd[ ]*$" "$ha ./"
  lbuf_subtract "ls[ ]*$" "$ha ./"
  lbuf_subtract "ll[ ]*$" "$ha ./"
  lbuf_subtract "vim[ ]*$" "$ha ./"
  lbuf_subtract "nvim[ ]*$" "$ha ./"
  lbuf_subtract "find[ ]*$" "$ha ./"
  lbuf_subtract "source[ ]*$" "$ha ./"
  if [[ $BUFFER =~ "^.*/$" ]]; then
    ha=$(bufheadargs)
    ta=$(buftailargs)
    lbuf_subtract_rbuf_eval "cd[ ]+.+$" "$ha " "fzf_list_dir $ta --PROMPT=$ha" && return 0
    lbuf_subtract_rbuf_eval "cd[ ]+.+$" "$ha " "fzf_list_dir $ta --PROMPT=$ha" && return 0
    lbuf_subtract_rbuf_eval "ls[ ]+.+$" "$ha " "fzf_list_file $ta --PROMPT=$ha" && return 0
    lbuf_subtract_rbuf_eval "ll[ ]+.+$" "$ha " "fzf_list_file $ta --PROMPT=$ha" && return 0
    lbuf_subtract_rbuf_eval "vim[ ]+.+$" "$ha " "fzf_list_file $ta --PROMPT=$ha" && return 0
    lbuf_subtract_rbuf_eval "nvim[ ]+.+$" "$ha " "fzf_list_file $ta --PROMPT=$ha" && return 0
    lbuf_subtract_rbuf_eval "find[ ]+.+$"  "$ha" "fzf_list_dir $ta --PROMPT=$ha" && return 0
    lbuf_subtract_rbuf_eval "source[ ]+.+$" "$ha " "fzf_list_file $ta --PROMPT=$ha" && return 0
  fi

  if $(is_git_repo); then
    lbuf_subtract_rbuf_eval "tig" "$ha " "git_branch_fzf" && return 0
    if [[ $BUFFER =~ "^.*origin/+$" ]]; then
      RBUFFER="$(git branch --show-current)"
      zle end-of-line
      return
    fi
  fi

  zle expand-or-complete
}
