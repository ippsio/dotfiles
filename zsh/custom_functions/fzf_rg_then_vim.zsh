# rg(ripgrep)の検索結果を選択I/Fを表示する。
# さらに、選択したファイルをvimで開く
# fzfのプレビューは、基本的に検索ヒットした行の5行前から表示する(decide_from)。
function fzf_rg_then_vim() {
  [ -z "$1" ] && echo 'Argument required' && return 0
  result=$(rg --line-number $1 \
    | perl -pe 's/(^.*):(\d+):(.*)$/\1 \2 \3/' \
    | fzf -m \
      --prompt="fzf_rg_then_vim> " \
      --bind "enter:execute(nvim {1} +{2} < /dev/tty > /dev/tty)" \
      --preview '
        decide_range_from() { echo $(( $1 - 5 > 0 ? $1 - 5 : 1)) };
        bat --color=always --style=numbers,header,grid \
          --line-range $(decide_range_from {2}): \
          --highlight-line {2} {1}'
  )
}
alias rgg="fzf_rg_then_vim"

# git grepの検索結果を選択I/Fを表示する。
# さらに、選択したファイルをvimで開く
# fzfのプレビューは、基本的に検索ヒットした行の5行前から表示する(decide_from)。
function fzf_git_grep_then_vim() {
  [ -z "$1" ] && echo 'Argument required' && return 0
  result=$(git grep --line-number $1 \
    | perl -pe 's/(^.*):(\d+):(.*)$/\1 \2 \3/' \
    | fzf -m \
      --prompt="fzf_git_grep_then_vim> " \
      --bind "enter:execute(nvim {1} +{2} < /dev/tty > /dev/tty)" \
      --preview '
        decide_range_from() { echo $(( $1 - 5 > 0 ? $1 - 5 : 1)) };
        bat --color=always --style=numbers,header,grid \
          --line-range $(decide_range_from {2}): \
          --highlight-line {2} {1}'
  )
}
alias ggv="fzf_git_grep_then_vim"
