# フォルダの選択I/Fを表示する。
# プレビュー：そのフォルダ内のファイル一覧。
fzf_list_dir() {
  find ${1/'~'/${HOME}} \
    -path '*/\.' -prune -o \
    -path '*/\.git' -prune -o \
    -type d \
    | sed -e 's#$#/#g' \
    | sed -e 's#\/\/*#\/#g' \
    | fzf +m \
    --prompt=${1/${HOME}/'~'} \
    --preview 'echo -n $(cd {}; pwd); echo '/'; echo; ls -UlaFG {}' \
    --preview-window=right:60%:wrap || echo $1
}

# ファイルの選択I/Fをする。
# プレビュー：ファイル内の内容。
fzf_list_file() {
  find ${1/'~'/${HOME}} \
    -path '*/\.' -prune -o \
    -path '*/\.git' -prune -o \
    -type f \
    | sed -e 's#\/\/*#\/#g' \
    | fzf +m \
    --prompt=${1/${HOME}/'~'} \
    --preview 'bat --color=always --style=header,grid --line-range :100 {}' \
    --preview-window=right:60%:wrap || echo $1
}

