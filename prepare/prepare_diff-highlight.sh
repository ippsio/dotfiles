#!/bin/sh
N="diff-highlight"
DIFF_HIGHLIGHT=$(find /opt/homebrew/Cellar/git -type f -name "diff-highlight" | sort -nr| head -n 1)
D=${DIFF_HIGHLIGHT}
if [ -e ${DIFF_HIGHLIGHT} ]; then
  export PATH=${PATH}:$(dirname ${DIFF_HIGHLIGHT})
else
  echo "${N} is not in /opt/homebrew/"
  return 1
fi
