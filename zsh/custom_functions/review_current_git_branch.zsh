review_current_git_branch() {
  if [ ! $(git rev-parse --is-inside-work-tree 2>/dev/null) ]; then
    echo "Not a git repository."
    return
  fi

  #merge_base_branch=${1:-origin/develop}
  #merge_base_branch=${1:-origin/$(fzf_git_branch)}
  merge_base_branch=$(fzf_git_branch origin_first_local_last)
  if [ ! $(git branch -a --format="%(refname:short)" | grep -e ^${merge_base_branch}$) ]; then
    [[ -z ${merge_base_branch} ]] && echo "Bye." && return
  fi

  if [ ! $(git branch -a --format="%(refname:short)" | grep -e ^${merge_base_branch}$) ]; then
    echo "Branch [${merge_base_branch}] not found. Bye." && return
  fi

  #if [[ ! ${merge_base_branch} =~ '^origin/' ]]; then
  #  merge_base_branch="origin/${merge_base_branch}"
  #fi
  merge_base_commit=$(git rev-parse --short $(git merge-base ${merge_base_branch} HEAD))
  current_branch=$(git branch --contains| tr -d "* ")

  while true; do
    # clear
    # git merge-base
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    printf "\e[33;7m[branches]\e[m\n"
    printf " [${merge_base_branch}] <= [${current_branch}]\n"
    printf "\e[33;7mgit rev-parse --short \$(git merge-base ${merge_base_branch} HEAD)\e[m\n"
    printf " ${merge_base_commit}\n"

    local commit_hash="%Cred%h%Creset"
    local author="%C(bold blue)%an%Creset"
    local subject="%s"
    local commit_date="%Cgreen(%cd)%Creset"
    local ref_names="%C(yellow)%d%Creset"

    # git log
    local commits_count_last=3
    local commits_count_total=$(git --no-pager log --oneline ${merge_base_commit}...HEAD| wc -l| tr -d ' ')
    printf "\e[33;7mgit --no-pager log --oneline ${merge_base_commit}...HEAD\e[m"
    printf "\e[33m\n (total commit count ${commits_count_total})\n\e[m"
    if [[ ${commits_count_total} -gt ${commits_count_last} ]]; then
      printf "\e[33m ($(( ${commits_count_total} - ${commits_count_last} )) commits here)  \n\e[m"
    fi
    git --no-pager log ${merge_base_commit}...HEAD --reverse --oneline -${commits_count_last} --color=always \
      --date=format-local:'%Y/%m/%d %H:%M:%S' \
      --pretty=format:"${commit_hash}${commit_date} ${author}${ref_names} ${subject}" \
      --abbrev-commit

    # File changed
    printf "\n\n\e[33;7m[file changed]\e[m"
    # (A)(B),どちらがしっくり来るか、体感中
    # (A)
    # printf "\e[33m - $(git diff --name-only ${merge_base_commit}...HEAD| wc -l| sed -e 's/ //g') files\n\e[m"
    # git diff --stat ${merge_base_commit}...HEAD
    # (B)
    printf "\e[33m\n ($(git diff --name-only ${merge_base_commit}| wc -l| sed -e 's/ //g') files)\n\e[m"
    git diff --stat ${merge_base_commit}

    printf '%*s' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    # Command
    printf "\n\e[33;7m[Command]\e[m\n"
    echo " 1 | v | ) show diff then open with tig/vim."
    echo " 2 | t )   tig ${merge_base_commit}...HEAD"
    echo " 3 | T )   tig -w ${merge_base_commit}...HEAD（tig＋空白無視オプション）"

    # (A)(B),どちらがしっくり来るか、体感中
    # (A)
    echo " 4 | d )   git diff ${merge_base_commit} | vim -R"
    # (B)
    echo " 5 | H )   git diff ${merge_base_commit}...HEAD | vim -R"
    echo -n " > "
    read REPLY
    case "${REPLY}" in
          1 | v | ) fzf_git_diff "${merge_base_commit}" "enter" ;;
          2 | t   ) tig ${merge_base_commit}...HEAD ;;
          3 | T   ) tig -w ${merge_base_commit}...HEAD ;;
          # (A)(B),どちらがしっくり来るか、体感中
          # (A)
          4 | d   ) git diff ${merge_base_commit} | vim -R ;;
          # (B)
          5 | H   ) git diff ${merge_base_commit}...HEAD | vim -R ;;
    esac
    clear
  done
}

alias rv="review_current_git_branch"
