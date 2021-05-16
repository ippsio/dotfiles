function gwt() {
  git worktree add $(`git rev-parse --show-cdup`)git-worktrees/$1 -b $1
}
