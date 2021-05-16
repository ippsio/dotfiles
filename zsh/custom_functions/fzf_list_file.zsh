# ファイルの選択I/Fをする。
# プレビュー：ファイル内の内容。
fzf_list_file() {
  #find $1 \
  find ${1/'~'/${HOME}} \
    -path '*/\.' -prune -o \
    -path '*/\.git' -prune -o \
    -type f \
    | sed -e 's#\/\/*#\/#g' \
    | sed -e "s#^${HOME}#~#" \
    | fzf +m \
    --prompt="fzf_list_file()> " \
    --preview 'bat $(echo $(cd $(dirname $(echo {}| sed -e "s#^~#${HOME}#")) && pwd)/$(echo {}| sed -e "s#^~#${HOME}#"| sed -e "s#^.*/##")) --color=always --style=header,grid --line-range :100' \
    --preview-window=right:60%:wrap || echo $1
}

#    --preview 'bat $(echo {}| sed -e "s#^~#${HOME}#") --color=always --style=header,grid --line-range :100' \