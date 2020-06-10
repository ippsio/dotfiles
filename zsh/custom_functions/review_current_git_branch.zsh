review_current_git_branch() {
  merge_base_branch=${1:-origin/develop}
  merge_base_commit=$(git rev-parse --short $(git merge-base ${merge_base_branch} HEAD))

  while true; do
    clear
    # git merge-base
    printf "\e[33mMERGE-BASE=${merge_base_branch}\e[m  \e[33m \"git merge-base ${merge_base_branch} HEAD\" = ${merge_base_commit}\e[m\n\n"

    local commit_hash="%Cred%h%Creset"
    local author="%C(bold blue)%an%Creset"
    local subject="%s"
    local commit_date="%Cgreen(%cd)%Creset"
    local ref_names="%C(yellow)%d%Creset"

    # git log
    local commits_count_last=3
    local commits_count_total=$(git --no-pager log --oneline ${merge_base_commit}...HEAD| wc -l| tr -d ' ')
    printf "\e[33;7m[git log]\e[m"
    printf "\e[33m - total commit count ${commits_count_total}. \n\e[m"
    if [[ ${commits_count_total} -gt ${commits_count_last} ]]; then
      printf "\e[33m      :\n\e[m"
      printf "\e[33m ($(( ${commits_count_total} - ${commits_count_last} )) commits here)  \n\e[m"
      printf "\e[33m      :\e\n[m"
    fi
    git --no-pager log ${merge_base_commit}...HEAD --reverse --oneline -${commits_count_last} --color=always \
      --date=format-local:'%Y/%m/%d %H:%M:%S' \
      --pretty=format:"${commit_hash}${commit_date} ${author}${ref_names} ${subject}" \
      --abbrev-commit

    # File changed
    printf "\n\n\e[33;7m[file changed]\e[m"
    printf "\e[33m - $(git diff --name-only ${merge_base_commit}...HEAD| wc -l| sed -e 's/ //g') files\n\e[m"
    git diff --stat ${merge_base_commit}...HEAD

    # Command
    printf "\n\e[33;7m[Command]\e[m\n"
    echo " 0 | v | ) show diff then open with tig/vim."
    echo " 1 | t )   tig -w ${merge_base_commit}...HEAD"
    echo " 2 | d )   git diff ${merge_base_commit}...HEAD | vim -R"
    echo -n " > "
    read REPLY
    case "${REPLY}" in
          0 | v | ) fzf_git_diff "${merge_base_branch}" "enter" ;;
          1 | t   ) tig -w ${merge_base_commit}...HEAD ;;
          2 | d   ) git diff ${merge_base_commit}...HEAD | vim -R ;;
    esac
  done
}

alias rv="review_current_git_branch"
