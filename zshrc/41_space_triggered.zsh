# スペースでよく使うコマンドを展開
function triggered_by_space() {
  #printf "BUFFER=[${BUFFER}] LBUFFER=[${LBUFFER}] RBUFFER=[${RBUFFER}]\n"

  # globalaliasの展開
  # NOTE: 一般的に大文字が使われるらしいので、ここでも大文字（と数字）でのみチェックしている。
  [[ $LBUFFER =~ ' [A-Z0-9]+$' ]] \
  && zle _expand_alias

  # ssh
  [[ $BUFFER =~ '^ssh+[ ]$' ]] \
  && BUFFER="ssh $(fgrep 'Host ' ~/.ssh/config | grep -v '*' |  awk '{print $2}' | sort | fzf)" \
  && zle end-of-line && return

  # scp
  [[ $BUFFER =~ '^scp+[ ]$' ]] \
  && BUFFER="scp $(fgrep 'Host ' ~/.ssh/config | grep -v '*' |  awk '{print $2}' | sort | fzf)" \
  && zle end-of-line && return

  # file or directory
  [[ $BUFFER =~ '[ ][ ]$' ]] \
    && BUFFER=" $(fzf_list_file ${BUFFER})" && zle end-of-line && return

  if $(is_git_repo); then
    # git grep
    [[ $BUFFER =~ '^gg+$' ]] \
      && BUFFER="git_grep_fzf_vim " && zle end-of-line && return

    # git
    [[ $BUFFER =~ '^g+$' ]] \
      && BUFFER="git " && zle end-of-line && return

    # git status
    [[ $BUFFER =~ '^gs+$' || $BUFFER =~ '^gst+$' || $BUFFER =~ '^git st+$' ]] \
      && BUFFER="git status " && zle end-of-line && return

    # git checkout + completion
    [[ $BUFFER =~ '^gco+$' || $BUFFER =~ '^git co+$' ]] \
    && zle autosuggest-clear && BUFFER="git checkout $(git_branch_fzf)" && zle end-of-line && return

    # git log + completion
    [[ $BUFFER =~ '^gl+$' || $BUFFER =~ '^glo+$' || $BUFFER =~ '^gitlog+$' ]] \
    && zle autosuggest-clear && BUFFER="git_log_fzf " && zle end-of-line && return

    # git branch + completion
    [[ $BUFFER =~ '^b+$' ]] \
    && zle autosuggest-clear \
    && BUFFER="git_branch_fzf" \
    && zle end-of-line \
    && BUFFER="$(git_branch_fzf)" \
    && zle end-of-line && return

    # git branch + completion
    [[ $BUFFER =~ '^.*B+$' ]] \
    && zle autosuggest-clear \
    && zle end-of-line \
    && BUFFER="${BUFFER%B}$(git_branch_fzf)" \
    && zle end-of-line && return

    # git fetch origin --prune
    [[ $BUFFER =~ '^gfo+$' || $BUFFER =~ '^git fo+$' ]] \
    && BUFFER="git fetch origin --prune " && zle end-of-line && return

    # git merge
    [[ $BUFFER =~ '^gme+$' || $BUFFER =~ '^git me+$' ]] \
    && BUFFER="git merge --ff" && zle end-of-line && return

    # git push origin HEAD
    [[ $BUFFER =~ '^gps+$' || $BUFFER =~ '^git ps+$' ]] \
    && BUFFER="git push origin HEAD " && zle end-of-line && return
  fi

  # bundle exec
  [[ $BUFFER =~ '^be+$' ]] \
  && BUFFER="bundle exec " && zle end-of-line && return

  # bundle exec rails
  [[ $BUFFER =~ '^rails+$' ]] \
  && BUFFER="bundle exec rails " && zle end-of-line && return

  # bundle exec rails c
  [[ $BUFFER =~ '^c+$' || $BUFFER =~ '^rc+$' ]] \
  && BUFFER="bundle exec rails c" && zle end-of-line && return

  #  bundle exec rake + completion
  [[ $BUFFER =~ '^rake+$' ]] \
  && BUFFER="bundle exec rake $(fzf_bundle_exec_rake)" && zle end-of-line && return

  # bundle exec rails s
  [[ $BUFFER =~ '^rs+$' || $BUFFER =~ '^bers+$' ]] \
  && BUFFER="bundle exec rails s -b 0.0.0.0" && zle end-of-line && return

  # rg
  [[ $BUFFER =~ '^rgg+$' ]] \
  && BUFFER="rg_fzf_vim " && zle end-of-line && return

  # docker exec
  # docker exec -it `docker ps -a | fzf | awk '{print $1}'` /bin/bash --login
  [[ $BUFFER =~ '^de+$' || $BUFFER =~ '^docker exec+$' ]] \
  && BUFFER="docker exec -it $(docker ps -a | fzf | awk '{print $1}') /bin/bash --login" && zle end-of-line && return

  # docker-compose
  [[ $BUFFER =~ '^dc+$' ]] \
  && BUFFER="docker-compose " && zle end-of-line && return

  # docker-compose up -d
  [[ $BUFFER =~ '^dcu+$' ]] \
  && BUFFER="docker-compose up -d" && zle end-of-line && return

  # docker-compose down
  [[ $BUFFER =~ '^dcd+$' ]] \
  && BUFFER="docker-compose down" && zle end-of-line && return

  zle self-insert
}

