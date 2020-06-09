fzf_preview_diff_files() {
  merge_base_branch=${1:-origin/develop}
  nvim_bind=${2:-ctrl-v}
  local merge_base_commit=$(git rev-parse --short $(git merge-base ${merge_base_branch} HEAD))
  local commit_hash="%Cred%h%Creset"
  local author="%C(bold blue)%an%Creset"
  local subject="%s"
  local commit_date="%Cgreen(%cd)%Creset"
  local ref_names="%C(yellow)%d%Creset"

  files=$(git diff --numstat ${merge_base_commit}...HEAD | awk '{printf "%+5s" , "+" $1} {printf "%+5s" , "-" $2} {printf "%s\n", ", " $3} ') || return
  target=$(echo "$files" | fzf --bind change:top --bind '?:toggle-preview' \
    --bind "right:execute(tig $merge_base_commit...HEAD {3} < /dev/tty > /dev/tty)" \
    --bind "ctrl-l:execute(tig $merge_base_commit...HEAD {3} < /dev/tty > /dev/tty)" \
    --bind "tab:execute(tig $merge_base_commit...HEAD {3} < /dev/tty > /dev/tty)" \
    --bind "${nvim_bind}:execute(nvim {3} < /dev/tty > /dev/tty)" --preview "
      git log ${merge_base_commit}...HEAD --oneline {3} | wc -l| tr -d ' '| sed -e 's/$/ total commits on this branch./'
      ;git log ${merge_base_commit}...HEAD --oneline -3 --color=always --decorate=full --date=format-local:'%Y/%m/%d %H:%M:%S' \
        --pretty=format:'${commit_hash}${commit_date} ${author}${ref_names} ${subject}' --abbrev-commit {3}
      ; echo ; echo
      ;git diff --color=always --stat ${merge_base_commit}...HEAD {3}
      ; echo
      ;git diff --color=always ${merge_base_commit}...HEAD {3}| diff-highlight | less" --preview-window=right:60%:wrap)
      echo $target | awk '{print $3}'
}

# rv[enter]で現在のgitブランチのレビューを開始
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
    echo " 0 | v | ) open file with vim or tig."
    echo " 1 | t )   tig -w ${merge_base_commit}...HEAD"
    echo " 2 | d )   git diff ${merge_base_commit}...HEAD | vim -R"
    echo -n " > "
    read REPLY
    case "${REPLY}" in
          0 | v | ) fzf_preview_diff_files "${merge_base_branch}" "enter" ;;
          2 | t   ) tig -w ${merge_base_commit}...HEAD ;;
          3 | d   ) git diff ${merge_base_commit}...HEAD | vim -R ;;
    esac
  done
}
alias rv="review_current_git_branch"
