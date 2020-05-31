function _fzf_with_preview_git_diff() {
  merge_base="$(git merge-base ${1:-origin/develop} HEAD)"
  local commit_hash="%Cred%h%Creset"
  local author="%C(bold blue)%an%Creset"
  local subject="%s"
  local commit_date="%Cgreen(%cd)%Creset"
  local ref_names="%C(yellow)%d%Creset"

  echo $(\
    git diff --numstat ${merge_base}...HEAD \
    | awk '\
      {printf "%+5s" , "+" $1} \
      {printf "%+5s" , "-" $2} \
      {printf "%s\n", ", " $3} \
    ' \
    | fzf --bind change:top \
    --preview " \
      # 全コミット数
      echo {} | sed -e 's/.*, //g' \
        | xargs git log ${merge_base}...HEAD --oneline \
        | wc -l \
        | tr -d ' ' \
        | sed -e 's/$/ total commits on this branch./' \
      # 直近3コミット
      ;echo {} | sed -e 's/.*, //g' | \
        xargs git log ${merge_base}...HEAD --oneline -3 \
        --color=always --decorate=full \
        --date=format-local:'%Y/%m/%d %H:%M:%S' \
        --pretty=format:'${commit_hash}${commit_date} ${author}${ref_names} ${subject}' \
        --abbrev-commit \
      # 改行
      ;echo \
      ;echo \
      # そのファイルのdiffstat
      ;echo {} | sed -e 's/.*, //g' \
        |xargs git diff --color=always --stat ${merge_base}...HEAD \
      # 改行
      ;echo \
      # そのファイルのdiff
      ;echo {} | sed -e 's/.*, //g'|xargs git diff --color=always ${merge_base}...HEAD| diff-highlight| less \
    " \
    --preview-window=right:60%:wrap \
    | sed -e 's/.*, //g' \
  )
}

# rv[enter]で現在のgitブランチのレビューを開始
function review_current_git_branch() {
  mbb=${1:-origin/develop}
  mb=$(git merge-base ${mbb} HEAD)

  while true; do
    clear
    # git merge-base
    printf "\e[33mMERGE-BASE=${mbb}\e[m\n"
    printf "\e[33m\"git merge-base ${mbb} HEAD\" = ${mb}\e[m\n\n"

    local commit_hash="%Cred%h%Creset"
    local author="%C(bold blue)%an%Creset"
    local subject="%s"
    local commit_date="%Cgreen(%cd)%Creset"
    local ref_names="%C(yellow)%d%Creset"

    # git log
    printf "\e[33;7m[git log]\e[m\n"
    git --no-pager log $(git merge-base ${mb} HEAD)...HEAD --reverse --oneline -5 --color=always \
      --date=format-local:'%Y/%m/%d %H:%M:%S' \
      --pretty=format:"${commit_hash}${commit_date} ${author}${ref_names} ${subject}" \
      --abbrev-commit
    printf "\n\e[33m- total commit count $(git --no-pager log --oneline ${mb}...HEAD| wc -l| sed -e 's/ //g'). \n\n\e[m"

    # File changed
    printf "\e[33;7m[file changed]\e[m\n"
    git diff --stat $(git merge-base ${mb} HEAD)...HEAD
    printf "\e[33m- $(git diff --name-only ${mb}...HEAD| wc -l| sed -e 's/ //g') files\n\n\e[m"

    # Command
    printf "\e[33;7m[Command]\e[m\n"
    echo "1 | git diff ) git diff \$(git merge-base ${mbb} HEAD)...HEAD"
    echo "3 | v | vim | [enter] ) vim"
    echo "4 | t ) tig file"
    echo "5 | tig ) tig -w --reverse \$(git merge-base ${mbb} HEAD)...HEAD"
    echo "9 | q | ctrl-c ) bye"
    echo -n " > "
    read REPLY
    case "${REPLY}" in
      1 ) git diff $(git merge-base ${mbb} HEAD)...HEAD ;;
      3 | v | vim ) f=$(_fzf_with_preview_git_diff) && [ ! -z $f ] && vim $f ;;
      4 | t )       f=$(_fzf_with_preview_git_diff) && [ ! -z $f ] && tig -w --reverse $(git merge-base ${mbb} HEAD)...HEAD $f ;;
      5 | tig | t ) tig -w --reverse $(git merge-base ${mbb} HEAD)...HEAD ;;
      5 | tigall | t ) tig -w --reverse $(git merge-base ${mbb} HEAD)...HEAD ;;
      9 | q | ctrl-c ) break ;;

    esac
  done
}
alias rv="review_current_git_branch"
