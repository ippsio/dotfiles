# emacs like
bindkey -e

# スペースでよく使うコマンドを展開
function _space_extraction() {
  #printf "BUFFER=[${BUFFER}] LBUFFER=[${LBUFFER}] RBUFFER=[${RBUFFER}]\n"

  # globalaliasの展開
  # NOTE: 一般的に大文字が使われるらしいので、ここでも大文字（と数字）でのみチェックしている。
  [[ $LBUFFER =~ ' [A-Z0-9]+$' ]] && zle _expand_alias

  # git
  [[ $BUFFER =~ '^g+$' ]]            && BUFFER="git " && zle end-of-line && return
  # git diff for short
  [[ $BUFFER =~ '^git di+$' ]]       && BUFFER="git diff " && zle end-of-line && return
  # git status for short
  [[ $BUFFER =~ '^gs+$' ]]           && BUFFER="git status -sb " && zle end-of-line && return
  [[ $BUFFER =~ '^git st+$' ]]       && BUFFER="git status " && zle end-of-line && return
  # git checkout completion
  [[ $BUFFER =~ '^gco+$' ]]          && BUFFER="git checkout $(fzf_git_branch)" && zle end-of-line && return
  [[ $BUFFER =~ '^git co+$' ]]       && BUFFER="git checkout $(fzf_git_branch)" && zle end-of-line && return
  [[ $BUFFER =~ '^git checkout+$' ]] && BUFFER="git checkout $(fzf_git_branch)" && zle end-of-line && return
  # git fetch origin --prune for short
  [[ $BUFFER =~ '^gfo+$' ]]          && BUFFER="git fetch origin --prune " && zle end-of-line && return
  [[ $BUFFER =~ '^git fo+$' ]]       && BUFFER="git fetch origin --prune " && zle end-of-line && return
  # git merge for short
  [[ $BUFFER =~ '^gme+$' ]]          && BUFFER="git merge " && zle end-of-line && return
  [[ $BUFFER =~ '^git me+$' ]]       && BUFFER="git merge " && zle end-of-line && return
  # git push origin HEAD for short
  [[ $BUFFER =~ '^gps+$' ]]          && BUFFER="git push origin HEAD " && zle end-of-line && return
  [[ $BUFFER =~ '^git ps+$' ]]       && BUFFER="git push origin HEAD " && zle end-of-line && return
  # bundle exec for short
  [[ $BUFFER =~ '^be+$' ]]   && BUFFER="bundle exec " && zle end-of-line && return
  # bundle exec rails c for short
  [[ $BUFFER =~ '^c+$' ]]    && BUFFER="bundle exec rails c" && zle end-of-line && return
  [[ $BUFFER =~ '^rc+$' ]]   && BUFFER="bundle exec rails c" && zle end-of-line && return
  [[ $BUFFER =~ '^rails+$' ]]   && BUFFER="bundle exec rails " && zle end-of-line && return
  [[ $BUFFER =~ '^rake+$' ]] && BUFFER="bundle exec rake $(fzf_bundle_exec_rake)" && zle end-of-line && return

  # bundle exec rails s for short
  [[ $BUFFER =~ '^rs+$' ]]   && BUFFER="bundle exec rails s -b 0.0.0.0" && zle end-of-line && return
  [[ $BUFFER =~ '^bers+$' ]] && BUFFER="bundle exec rails s -b 0.0.0.0" && zle end-of-line && return
  # dockero-compose for short
  [[ $BUFFER =~ '^dc+$' ]] && BUFFER="docker-compose " && zle end-of-line && return
  zle self-insert
}
zle -N _space_extraction
bindkey " " _space_extraction

# TAB(=CTRL+I)補完
function _tab_completion() {
  # cd にfzfで補完候補を付ける
  [[ $BUFFER =~ '^cd *$' ]] && BUFFER="cd ./" && zle end-of-line # zle end-of-lineの後に && returnしないのは意図的
  [[ $BUFFER =~ '^cd *.+/+$' ]] && BUFFER="cd $(fzf_list_dir ${${BUFFER#cd }:-.})" && zle end-of-line && return

  # vim にfzfで補完候補を付ける
  [[ $BUFFER =~ '^vim *$' ]] && BUFFER="vim ./" && zle end-of-line # zle end-of-lineの後に && returnしないのは意図的
  [[ $BUFFER =~ '^vim *.+/+$' ]] && BUFFER="vim $(fzf_list_file ${${BUFFER#vim }:-.})" && zle end-of-line && return

  # 上記にヒットしなかたら、普通っぽい挙動にする
  zle expand-or-complete
}

# TAB(=CTRL+I)補完
zle -N _tab_completion
bindkey "^I" _tab_completion

# ^で一つ上のフォルダへ移動
function hat_cdup () { [[ ${BUFFER} == "" ]] && cd .. && zle accept-line && zle reset-prompt && return || zle self-insert }
zle -N hat_cdup
bindkey "\^" hat_cdup

# CTRL-D,DELで前方削除
bindkey "^[[3~" delete-char

