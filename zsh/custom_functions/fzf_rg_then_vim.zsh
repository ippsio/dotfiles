# rgの検索結果を選択I/Fを表示する。
# さらに、選択したファイルはvimで開く
function fzf_rg_then_vim() {
  [ -z "$1" ] && echo 'Usage: rgg PATTERN' && return 0
  result=$(rg --line-number $1 \
    | perl -pe 's/(^.*):(\d+):(.*)$/\1 \2 \3/' \
    | fzf -m \
      --bind "enter:execute(nvim {1} +{2} < /dev/tty > /dev/tty)" \
      --preview "bat --color=always --style=numbers,header,grid --line-range :65535 {1}"
  )
}

alias rgg="fzf_rg_then_vim"
