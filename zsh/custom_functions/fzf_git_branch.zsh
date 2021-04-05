# git checkout用の選択候補を表示する。
# プレビューとして、ブランチのgit logを表示する。
fzf_git_branch() {
  local origin_local=$1
  local fixed="develop\n-- .\n-- \n-b "
  #local dynamic="$(git branch -a --format="%(refname:short)"| sed -e 's/^[\* ]*//' | sed -e 's/^[ ]*//g'| sort)"
  local dynamic="$(git branch -a --format="%(refname:short)"| sed -e 's/^origin\///g'| sort| uniq|grep -v "^develop$")"
  local candidates="${fixed}\n${dynamic}"

  # git logのプレビュー表示が不要な場合はこちら。
  target=$(echo ${candidates} \
    |fzf \
    --prompt="fzf_git_branch > " \
    | sed -e "s/^[\* ]*//" \
    | sed -e "s/^remotes\/origin\///" \
    || echo "")
  # git logのプレビューを表示したい場合はこちら。
  #target=$(echo ${candidates} \
  #  |fzf \
  #  --prompt='git checkout> ' \
  #  --preview "\
  #  echo \[{}\]; echo; [[ {} =~ '^(-- |-- .|-b)' ]] && echo 'not a branch.' \
  #    || git log  \
  #      --graph \
  #      --color=always \
  #      --date=format-local:'%Y/%m/%d %H:%M:%S' \
  #      --pretty=format:'%C(010 022)%h%C(reset) %C(039 017)(%cd)%C(reset) %C(079)%an%C(reset) %C(226 021)%d%C(reset)%s' \
  #      --abbrev-commit {} \
  #  " \
  #  --preview-window=right:70%:wrap \
  #  | sed -e "s/^[\* ]*//" \
  #  | sed -e "s/^remotes\/origin\///" \
  #  || echo "")
  if [[ "${target}" != "" ]]; then
    if [[ "${target}" == "-- " ||  "${target}" == "-- ." ]]; then
      target=$(echo ${target})
    elif [[ "${origin_local}" == "" || "${origin_local}" == "origin_first_local_last" ]]; then
      target=$(echo "(REMOTE) origin/${target}\n(LOCAL)  ${target}" | fzf --prompt="LOCAL OR REMOTE? > "| awk '{print $2}')
    elif [[ "${origin_local}" == "local_first_origin_last" ]]; then
      target=$(echo "(LOCAL)  ${target}\n(REMOTE) origin/${target}" | fzf --prompt="LOCAL OR REMOTE? > "| awk '{print $2}')
    fi
  fi
  echo "${target}"
}
