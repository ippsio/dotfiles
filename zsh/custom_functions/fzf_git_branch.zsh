# git checkout用の選択候補を表示する。
# プレビューとして、ブランチのgit logを表示する。
fzf_git_branch() {
  local fixed="develop\n-- \n-- .\n-b "
  #local dynamic="$(git branch -a --format="%(refname:short)"| sed -e 's/^[\* ]*//' | sed -e 's/^[ ]*//g'| sort)"
  local dynamic="$(git branch -a --format="%(refname:short)"| sed -e 's/^origin\///g'| sort| uniq)"
  local candidates="${fixed}\n${dynamic}"

  target=$(echo ${candidates} \
    |fzf \
    --prompt='git checkout> ' \
    --preview "\
    echo \[{}\]; echo; [[ {} =~ '^(-- |-- .|-b)' ]] && echo 'not a branch.' \
      || git log  \
        --graph \
        --color=always \
        --date=format-local:'%Y/%m/%d %H:%M:%S' \
        --pretty=format:'%C(010 022)%h%C(reset) %C(039 017)(%cd)%C(reset) %C(079)%an%C(reset) %C(226 021)%d%C(reset)%s' \
        --abbrev-commit {} \
    " \
    --preview-window=right:70%:wrap \
    | sed -e "s/^[\* ]*//" \
    | sed -e "s/^remotes\/origin\///" \
    || echo "")
  echo "${target}"
}
