# スペースでよく使うコマンドを展開
function _space_extraction() {
  #printf "BUFFER=[${BUFFER}] LBUFFER=[${LBUFFER}] RBUFFER=[${RBUFFER}]\n"

  # globalaliasの展開
  # NOTE: 一般的に大文字が使われるらしいので、ここでも大文字（と数字）でのみチェックしている。
  [[ $LBUFFER =~ ' [A-Z0-9]+$' ]] && zle _expand_alias

  # よく使うコマンドの展開
  [[ $BUFFER =~ '^gs+$' ]] && BUFFER="git status -sb " && zle end-of-line && return
  [[ $BUFFER =~ '^gd+$' ]] && BUFFER="git diff " && zle end-of-line && return
  [[ $BUFFER =~ '^git st+$' ]] && BUFFER="git status " && zle end-of-line && return
  [[ $BUFFER =~ '^git co+$' ]] && BUFFER="git checkout " && zle end-of-line && return
  [[ $BUFFER =~ '^git fo+$' ]] && BUFFER="git fetch origin --prune " && zle end-of-line && return
  [[ $BUFFER =~ '^git me+$' ]] && BUFFER="git merge " && zle end-of-line && return
  [[ $BUFFER =~ '^be+$' ]] && BUFFER="bundle exec " && zle end-of-line && return
  [[ $BUFFER =~ '^v+$' ]] && BUFFER="vim " && zle end-of-line && return
  [[ $BUFFER =~ '^dc+$' ]] && BUFFER="docker-compose " && zle end-of-line && return
  zle self-insert
  #[[ $LBUFFER =~ ' $' ]] && zle end-of-line
}
zle -N _space_extraction
bindkey " " _space_extraction

# ^で一つ上のフォルダへ移動
function hat_cdup () { [[ ${BUFFER} == "" ]] && cd .. && zle accept-line && zle reset-prompt && return || zle self-insert }
zle -N hat_cdup
bindkey "\^" hat_cdup

# CTRL-D,DELで前方削除
bindkey "^[[3~" delete-char
