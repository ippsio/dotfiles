# スペースでよく使うコマンドを展開
function triggered_by_space() {
  #printf "BUFFER=[${BUFFER}] LBUFFER=[${LBUFFER}] RBUFFER=[${RBUFFER}]\n"

  # globalaliasの展開
  # NOTE: 一般的に大文字が使われるらしいので、ここでも大文字（と数字）でのみチェックしている。
  [[ $LBUFFER =~ ' [A-Z0-9]+$' ]] \
  && zle _expand_alias

  # ssh
  [[ $BUFFER =~ '^ssh+$' ]] \
  && BUFFER="ssh $(fgrep 'Host ' ~/.ssh/config | grep -v '*' |  awk '{print $2}' | sort | fzf)" \
  && zle end-of-line && return

  # scp
  [[ $BUFFER =~ '^scp+$' ]] \
  && BUFFER="scp $(fgrep 'Host ' ~/.ssh/config | grep -v '*' |  awk '{print $2}' | sort | fzf)" \
  && zle end-of-line && return

  # git grep
  [[ $BUFFER =~ '^gg+$' ]] \
  && BUFFER="git_grep_fzf " \
  && zle end-of-line && return

  # git diff
  [[ $BUFFER =~ '^git di+$' ]] \
  && BUFFER="git diff " \
  && zle end-of-line && return

  # git status
  [[ $BUFFER =~ '^gs+$' || $BUFFER =~ '^gst+$' || $BUFFER =~ '^git st+$' ]] \
  && BUFFER="git status " \
  && zle end-of-line && return

  # git checkout + completion
  #[[ $BUFFER =~ '^gco+$' || $BUFFER =~ '^git co+$' || $BUFFER =~ '^git checkout+$' ]] \
  [[ $BUFFER =~ '^gco+$' || $BUFFER =~ '^git co+$' ]] \
  && zle autosuggest-clear \
  && BUFFER="git checkout $(fzf_git_branch local_first_origin_last)" \
  && zle end-of-line && return

  # git fetch origin --prune
  [[ $BUFFER =~ '^gfo+$' || $BUFFER =~ '^git fo+$' ]] \
  && BUFFER="git fetch origin --prune " \
  && zle end-of-line && return

  # git merge
  [[ $BUFFER =~ '^gme+$' || $BUFFER =~ '^git me+$' ]] \
  && BUFFER="git merge " \
  && zle end-of-line && return

  # git push origin HEAD
  [[ $BUFFER =~ '^gps+$' || $BUFFER =~ '^git ps+$' ]] \
  && BUFFER="git push origin HEAD " \
  && zle end-of-line && return

  # bundle exec
  [[ $BUFFER =~ '^be+$' ]] \
  && BUFFER="bundle exec " \
  && zle end-of-line && return

  # bundle exec rails
  [[ $BUFFER =~ '^rails+$' ]] \
  && BUFFER="bundle exec rails " \
  && zle end-of-line && return

  # bundle exec rails c
  [[ $BUFFER =~ '^c+$' || $BUFFER =~ '^rc+$' ]] \
  && BUFFER="bundle exec rails c" \
  && zle end-of-line && return

  #  bundle exec rake + completion
  [[ $BUFFER =~ '^rake+$' ]] \
  && BUFFER="bundle exec rake $(fzf_bundle_exec_rake)" \
  && zle end-of-line && return

  # bundle exec rails s
  [[ $BUFFER =~ '^rs+$' || $BUFFER =~ '^bers+$' ]] \
  && BUFFER="bundle exec rails s -b 0.0.0.0" \
  && zle end-of-line && return

  # rg
  [[ $BUFFER =~ '^rgg+$' ]] \
  && BUFFER="fzf_rg_then_vim " \
  && zle end-of-line && return

  # docker exec
  # docker exec -it `docker ps -a | fzf | awk '{print $1}'` /bin/bash --login
  [[ $BUFFER =~ '^docker exec+$' ]] \
  && BUFFER="docker exec -it $(docker ps -a | fzf | awk '{print $1}') /bin/bash --login" \
  && zle end-of-line && return

  # dockero-compose
  [[ $BUFFER =~ '^dc+$' ]] \
  && BUFFER="docker-compose " \
  && zle end-of-line && return

  zle self-insert
}

