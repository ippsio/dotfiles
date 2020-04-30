# rgの結果をfzfで絞り込み選択するとvimで開く
function search_with_rg_then_open_with_vim() {
  [ -z "$1" ] && echo 'Usage: rgg PATTERN' && return 0
  result=`rg --line-number $1 | fzf`
  line=`echo "$result" | awk -F ':' '{print $2}'`
  file=`echo "$result" | awk -F ':' '{print $1}'`
  if [ -n "$file" ]; then
    vim $file +$line
  fi
  echo "search_with_rg_then_open_with_vim done."
}

alias rgg="search_with_rg_then_open_with_vim"
