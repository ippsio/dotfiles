#!/usr/bin/env bash

readonly AWK_CMD="awk '
  BEGIN { count=0 }
  {
    files[NR]=\$0
    count++
  } END {
    for (i=1; i<=count; i++) {
      printf \"(%d/%d:git-grep)	%s\n\", i, count, files[i]
    }
  }'"
readonly GIT_GREP_CMD="git -c grep.fallbackToNoIndex=true grep -I --line-number --fixed-strings"
# shellcheck disable=SC2034 #(GIT_GREP_CMD_START appears unused. Verify use (or export if used externally).)
readonly GIT_GREP_CMD_START="${GIT_GREP_CMD} --null --color=always '$1'| perl -pe 's/\x0/\t/g'| ${AWK_CMD}"

