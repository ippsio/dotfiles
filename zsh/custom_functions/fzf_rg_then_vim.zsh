# rgの検索結果を選択I/Fを表示する。
# さらに、選択したファイルはvimで開く
function fzf_rg_then_vim() {
  [ -z "$1" ] && echo 'Usage: rgg PATTERN' && return 0
  result=$(rg --line-number $1 \
    | xargs -I print \
    | awk -F ':' '{ print $1 " " $2 " " $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14 $15 $16 $17 $18 $19 $20 $21 $22 $23 $24}' \
    | fzf -m \
      --bind "enter:execute(nvim {1} +{2} < /dev/tty > /dev/tty)" \
      --preview "bat --color=always --style=numbers,header,grid --line-range :65535 {1}"
  )
  file=`echo "$result" | awk '{print $1}'`
  line=`echo "$result" | awk '{print $2}'`
  if [ -n "$file" ]; then
    vim $file +$line
  fi
}

alias rgg="fzf_rg_then_vim"
