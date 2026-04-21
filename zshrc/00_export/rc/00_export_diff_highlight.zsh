#!/usr/bin/env zsh
dirs=(/opt/homebrew/Cellar/git/*/share/git-core/contrib/diff-highlight(N/))
for d in $dirs; do
  PATH="$d:$PATH"
done
export PATH
