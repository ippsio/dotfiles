# 指定ブランチとのgit diffをfzfで表示する。
# プレビューとして、該当ファイルの差分を表示する。
# TAB、CTRL-L、カーソルキー右でtigを開く。
# enterで、たぶんvimが開く。
fzf_git_diff() {
  local merge_base_commit=$1
  local nvim_bind=${2:-ctrl-v}

  #--bind "tab:execute(git diff --color=always $merge_base_commit {3} < /dev/tty |less -eR > /dev/tty)" \
  files=$(git diff --numstat ${merge_base_commit} | awk '{printf "%+5s" , "+" $1} {printf "%+5s" , "-" $2} {printf "%s\n", ", " $3} ') || return
  target=$(echo "$files" | \
    fzf \
    --prompt="fzf_git_diff>" \
    --header="(${nvim_bind}=> nvim)  (right,ctrl-l) (tab=> git diff)  (?=> toggle preview)" \
    --bind change:top \
    --bind "${nvim_bind}:execute(nvim {3} < /dev/tty > /dev/tty)" \
    --bind "right:execute(tig $merge_base_commit...HEAD {3} < /dev/tty > /dev/tty)" \
    --bind "ctrl-l:execute(tig $merge_base_commit {3}...HEAD < /dev/tty > /dev/tty)" \
    --bind "tab:execute(git diff --color=auto $merge_base_commit {3}< /dev/tty  |nvim -R > /dev/tty)" \
    --bind '?:toggle-preview' \
    --preview "
      [ ! -e {3} ] \
        && ( \
             echo 'NOT FOUND: {3}' \
           ) \
        || ( \
             git log ${merge_base_commit}.. --oneline {3} | wc -l| tr -d ' '| sed -e 's/$/ total commits on this branch(merge_base_commit=${merge_base_commit})./'
             ;git log ${merge_base_commit}.. --oneline -3 --color=always --decorate=full --date=format-local:'%Y/%m/%d %H:%M:%S' \
               --pretty=format:'%C(010 022)%h%C(reset) %C(039 017)(%cd)%C(reset) %C(079)%an%C(reset) %C(226 021)%d%C(reset)%s' --abbrev-commit {3}
             ; echo ; echo
             ;git diff --color=always --stat ${merge_base_commit} {3}
             ; echo
             ;git diff --color=always ${merge_base_commit} {3}| diff-highlight | less \
           ) \
      " --preview-window=bottom:60%:wrap)
      echo $target | awk '{print $3}'
}
