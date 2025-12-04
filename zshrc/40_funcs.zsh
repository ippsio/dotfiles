#!/usr/bin/env zsh

# buf1_match() {
#   printf "%s" "$BUFFER"| grep -E "^$1[ ]*$">/dev/null 2>&1
# }
buf1_match() {
  [[ "$BUFFER" =~ "^${1//\\/\\\\}[[:space:]]*$" ]]
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
lbuf_subtract() {
  buf1_match "$1"|| return 1
  LBUFFER="$2"
  zle end-of-line
}
lbuf_subtract_back() {
  lbuf_subtract "$1" "$2"|| return 1
  zle backward-char
}
lbuf_subtract_accept() {
  lbuf_subtract "$1" "$2"|| return 1
  zle accept-line
}
lbuf_subtract_rbuf_eval() {
  buf1_match "$1"|| return 1
  v=$(eval "$3")
  lbuf_subtract "$1" "$2"
  RBUFFER+="$v"
  zle end-of-line
}
