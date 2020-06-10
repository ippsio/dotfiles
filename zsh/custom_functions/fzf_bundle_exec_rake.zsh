# bundle exec rakeで実行するタスクの候補を表示する。
# プレビューとして、タスクのソースコードを表示する。
fzf_bundle_exec_rake() {
  merge_base_branch=${1:-origin/develop}
  local merge_base_commit=$(git rev-parse --short $(git merge-base ${merge_base_branch} HEAD))
  local commit_hash="%Cred%h%Creset"
  local author="%C(bold blue)%an%Creset"
  local subject="%s"
  local commit_date="%Cgreen(%cd)%Creset"
  local ref_names="%C(yellow)%d%Creset"

  files=$(find . -name vendor -prune -o -name '*.rake' -print) || return
  target=$(
    echo "$files" \
    | fzf \
    --bind change:top \
    --bind '?:toggle-preview' \
    --bind "ctrl-v:execute(nvim {} < /dev/tty > /dev/tty)" \
    --preview "bat --color=always {}" \
    --preview-window=right:60%:wrap
  )
  echo "${target}" | perl -pe 's#.*/##g' | perl -pe 's#\.rake$/##g'
}
