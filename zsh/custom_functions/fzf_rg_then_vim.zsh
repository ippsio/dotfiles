# rgの検索結果を選択I/Fを表示する。
# さらに、選択したファイルはvimで開く
function fzf_rg_then_vim() {
  [ -z "$1" ] && echo 'Usage: rgg PATTERN' && return 0
  result=`rg --line-number $1 | fzf`
  line=`echo "$result" | awk -F ':' '{print $2}'`
  file=`echo "$result" | awk -F ':' '{print $1}'`
  if [ -n "$file" ]; then
    vim $file +$line
  fi
}

alias rgg="fzf_rg_then_vim"
