#!/usr/bin/env zsh
for dir in $(find -s /opt/homebrew/Cellar/git/*/share/git-core/contrib/diff-highlight -type d -depth 0); do
  PATH=$dir:$PATH
done
export PATH
