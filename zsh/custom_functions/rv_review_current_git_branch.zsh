function _fzf_with_preview_git_diff() {
  merge_base="$(git merge-base ${mbb} HEAD)...HEAD"
  preview="git diff --stat ${merge_base} {}"
  preview="${preview};echo"
  preview="${preview};[ -e {} ] && git diff --color=always ${merge_base} {}| diff-highlight| less"
  echo "$(git diff --name-only ${merge_base}| fzf --preview "${preview}" --preview-window=right:60%:wrap)"
}

function _fzf_git_log() {
  mbb=${1:-origin/develop}
  mb=$(git merge-base ${mbb} HEAD)
  CMD="git --no-pager log $(git merge-base ${mb} HEAD)...HEAD \
    --oneline \
    --decorate=full \
    --date=iso \
    --pretty=format:'%Cred%h%Creset %Cgreen(%cd) %C(yellow)%d%Creset %s %C(bold blue)<%an>%Creset' \
    --abbrev-commit"

  echo "$(git diff --name-only $(git merge-base ${mbb} HEAD)...HEAD| fzf --preview "echo '[ファイル]\n{}\n'; [ -e {} ] && echo '\n----------------\n[commits]' && ${CMD} {}" --preview-window=right:60%:wrap)"
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

    # git log
    printf "\e[33;7m[git log]\e[m\n"
    CMD="git --no-pager log $(git merge-base ${mb} HEAD)...HEAD \
      --reverse \
      --oneline \
      --date=local \
      --pretty=format:'%Cred%h%Creset %Cgreen(%cr) %C(yellow)%d%Creset %s %C(bold blue)<%an>%Creset' \
      --abbrev-commit"
    echo "${CMD}\n"| sed -e "s/  //g"| sed -e "s@${mb}@\$(git merge-base ${mbb} HEAD)@"
    bash -c $CMD
    printf "\e[33m- $(git --no-pager log --oneline ${mb}...HEAD| wc -l| sed -e 's/ //g') commits\n\n\e[m"

    # File changed
    printf "\e[33;7m[file changed]\e[m\n"
    echo "git diff --no-pager --stat $(git merge-base ${mb} HEAD) HEAD\n"| sed -e "s@${mb}@\$(git merge-base ${mbb} HEAD)@"
    git diff --no-pager --stat $(git merge-base ${mb} HEAD) HEAD
    printf "\e[33m- $(git diff --name-only ${mb}...HEAD| wc -l| sed -e 's/ //g') files\n\n\e[m"

    # Command
    printf "\e[33;7m[Command]\e[m\n"
    echo "1 | git diff ) git diff \$(git merge-base ${mbb} HEAD)...HEAD"
    echo "2 | rubocop ) rubocop + reviewdog"
    echo "3 | v | vim | [enter] ) vim"
    echo "4 | t ) tig file"
    echo "5 | tig ) tig -w --reverse \$(git merge-base ${mbb} HEAD)...HEAD"
    echo "9 | q | ctrl-c ) bye"
    echo -n " > "
    read REPLY
    case "${REPLY}" in
      1 ) git diff $(git merge-base ${mbb} HEAD)...HEAD ;;
      3 | v | vim ) f=$(_fzf_with_preview_git_diff) && [ ! -z $f ] && vim $f ;;
      4 | t )       f=$(_fzf_git_log) && [ ! -z $f ] && tig -w --reverse $(git merge-base ${mbb} HEAD)...HEAD $f ;;
      5 | tig | t ) tig -w --reverse $(git merge-base ${mbb} HEAD)...HEAD ;;
      5 | tigall | t ) tig -w --reverse $(git merge-base ${mbb} HEAD)...HEAD ;;
      9 | q | ctrl-c ) break ;;

    esac
  done
}
alias rv="review_current_git_branch"
