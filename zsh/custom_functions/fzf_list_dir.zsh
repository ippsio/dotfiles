# フォルダの選択I/Fを表示する。
# プレビュー：そのフォルダ内のファイル一覧。
fzf_list_dir() {
  # find $1 \
  find ${1/'~'/${HOME}} \
    -path '*/\.' -prune -o \
    -path '*/\.git' -prune -o \
    -type d \
    | sed -e 's#$#/#g' \
    | sed -e 's#\/\/*#\/#g' \
    | sed -e "s#^${HOME}#~#" \
    | fzf +m \
    --prompt="fzf_list_dir()> " \
    --preview 'echo -n $(cd $(echo {}| sed -e "s#^~#${HOME}#"); pwd); echo '/'; echo; ls -UlaFG $(echo {}| sed -e "s#^~#${HOME}#")' \
    --preview-window=right:60%:wrap || echo $1
}
