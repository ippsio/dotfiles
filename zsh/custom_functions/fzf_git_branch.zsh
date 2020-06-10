# git checkout用の選択候補を表示する。
# プレビューとして、ブランチのgit logを表示する。
fzf_git_branch() {
  local fixed="-- \n-- .\n-b "
  local dynamic="$(git branch -a| sed -e 's/^[\* ]*//' | sed -e 's/^[ ]*//g'| sort)"
  local candidates="${fixed}\n${dynamic}"

  local commit_hash="%Cred%h%Creset"
  local author="%C(bold blue)%an%Creset"
  local subject="%s"
  local commit_date="%Cgreen(%cd)%Creset"
  local ref_names="%C(yellow)%d%Creset"

  local git_log="git log
    --graph
    --color=always
    --date=format-local:'%Y/%m/%d %H:%M:%S'
    --pretty=format:'${commit_hash}${commit_date} ${author}${ref_names} ${subject}'
    --abbrev-commit
    {}"
  echo ${candidates} | fzf \
    --prompt='git checkout> ' \
    --preview "echo {}; echo; ${git_log}" \
    --preview-window=right:70%:wrap \
    | sed -e "s/^[\* ]*//" \
    | sed -e "s/^remotes\/origin\///"
}
