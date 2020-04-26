function _rubocop_reviewdog() {
  for RUBOCOP_YML in .rubocop.yml .rubocop_strict.yml; do
    printf "\e[23;46;1m ${RUBOCOP_YML}\e[m\n"
    command="git diff --name-only $(git merge-base $1 HEAD)...HEAD"
    command="${command} | grep -e '^\(app\|lib\|config\).*\.\(rb\|rake\)$'"
    command="${command} | grep -v -e '\(db\|environments/\|deploy/\)'"
    command="${command} | grep -v -e '\(routes\|schedule\)\.rb'"
    command="${command} | xargs bundle exec rubocop -c ${RUBOCOP_YML}"
    command="${command} | ${REVIEWDOG_DIR}/reviewdog -f=rubocop -diff=\"git diff $(git merge-base $1 HEAD)...HEAD\""
    eval $command 2>&1 \
      | grep -v "warning: parser/current is loading parser/ruby22, which recognizes" \
      | grep -v "warning: 2.2.3-compliant syntax, but you are running 2.2.1." \
      | grep -v "warning: please see https://github.com/whitequark/parser#compatibility-with-ruby-mri."
    echo ""
  done
}
function _fzf_with_preview_git_diff() {
  echo "$(git diff --name-only $(git merge-base ${mbb} HEAD)...HEAD| fzf --preview "git diff --stat $(git merge-base ${mbb} HEAD)...HEAD {}; echo "";[ -e {} ] && git diff --color=always $(git merge-base ${mbb} HEAD)...HEAD {}" --preview-window=right:60%:wrap)"
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
function _review_git_request() {
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
      2 | rubo | rubocop ) _rubocop_reviewdog "${mbb}" ;;
      #3 | v | vim ) f=$(git diff --name-only $(git merge-base ${mbb} HEAD)...HEAD| fzf --preview "git diff --color=always $(git merge-base ${mbb} HEAD)...HEAD {}" --preview-window=right:60%:wrap) && [ ! -z $f ] && vim $f ;;
      3 | v | vim ) f=$(_fzf_with_preview_git_diff) && [ ! -z $f ] && vim $f ;;
      4 | t )       f=$(_fzf_git_log) && [ ! -z $f ] && tig -w --reverse $(git merge-base ${mbb} HEAD)...HEAD $f ;;
      5 | tig | t ) tig -w --reverse $(git merge-base ${mbb} HEAD)...HEAD ;;
      5 | tigall | t ) tig -w --reverse $(git merge-base ${mbb} HEAD)...HEAD ;;
      9 | q | ctrl-c ) break ;;

    esac
    #echo -n "Hit enter"; read _
  done
}
alias rv="_review_git_request"

# agの結果をfzfで絞り込み選択するとvimで開く
alias agg="_agAndVim"
function _agAndVim() {
  if [ -z "$1" ]; then
    echo 'Usage: agg PATTERN'
    return 0
  fi
  result=`ag $1 | fzf`
  line=`echo "$result" | awk -F ':' '{print $2}'`
  file=`echo "$result" | awk -F ':' '{print $1}'`
  if [ -n "$file" ]; then
    nvim $file +$line
  fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

