#!/usr/bin/env zsh

isbuf() {
  printf "%s" "$BUFFER"| grep -E "^$1[ ]*$">/dev/null 2>&1
}
addsp() {
  LBUFFER+=" "
}
lbuf() {
  LBUFFER="$1"
  zle end-of-line
  return 0
}
rbuf() {
  RBUFFER+=$(eval "$1")
  zle end-of-line
  return 0
}
bufheadargs() {
  printf "%s" "$BUFFER"| awk '{ print $1 }'
}
buftailargs() {
  printf "%s" "$BUFFER"| sed -E 's/^[a-zA-Z0-9]+[ ]+//'
}
expand_global_alias() {
  # globalaliasの展開。globalaliasは一般的に大文字が使われるらしいので、大文字(と数字)の有無を元に_expand_aliasするかどうかを判定します。ただし僕のzshrcではglobalaliasを1つも設定していない気もする。
  if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
    zle _expand_alias
  fi
}
