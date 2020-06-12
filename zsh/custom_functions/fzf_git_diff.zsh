# 指定ブランチとのgit diffをfzfで表示する。
# プレビューとして、該当ファイルの差分を表示する。
# TAB、CTRL-L、カーソルキー右でtigを開く。
# enterで、たぶんvimが開く。
fzf_git_diff() {
  merge_base_branch=${1:-origin/develop}
  nvim_bind=${2:-ctrl-v}
  local merge_base_commit=$(git rev-parse --short $(git merge-base ${merge_base_branch} HEAD))
  local commit_hash="%Cred%h%Creset"
  local author="%C(bold blue)%an%Creset"
  local subject="%s"
  local commit_date="%Cgreen(%cd)%Creset"
  local ref_names="%C(yellow)%d%Creset"

  files=$(git diff --numstat ${merge_base_commit}...HEAD | awk '{printf "%+5s" , "+" $1} {printf "%+5s" , "-" $2} {printf "%s\n", ", " $3} ') || return
  target=$(echo "$files" | \
    fzf \
    --header="(<${nvim_bind}>: open nvim)/ (<right>,ctrl-l,tab: open tig)/ (?: toggle preview)" \
    --bind change:top \
    --bind "${nvim_bind}:execute(nvim {3} < /dev/tty > /dev/tty)" \
    --bind "right:execute(tig $merge_base_commit...HEAD {3} < /dev/tty > /dev/tty)" \
    --bind "ctrl-l:execute(tig $merge_base_commit...HEAD {3} < /dev/tty > /dev/tty)" \
    --bind "tab:execute(tig $merge_base_commit...HEAD {3} < /dev/tty > /dev/tty)" \
    --bind '?:toggle-preview' \
    --preview "
      git log ${merge_base_commit}...HEAD --oneline {3} | wc -l| tr -d ' '| sed -e 's/$/ total commits on this branch./'
      ;git log ${merge_base_commit}...HEAD --oneline -3 --color=always --decorate=full --date=format-local:'%Y/%m/%d %H:%M:%S' \
        --pretty=format:'${commit_hash}${commit_date} ${author}${ref_names} ${subject}' --abbrev-commit {3}
      ; echo ; echo
      ;git diff --color=always --stat ${merge_base_commit}...HEAD {3}
      ; echo
      ;git diff --color=always ${merge_base_commit}...HEAD {3}| diff-highlight | less" --preview-window=right:60%:wrap)
      echo $target | awk '{print $3}'
}
