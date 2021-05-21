#!/bin/sh
N="diff-highlight"
DIFF_HIGHLIGHT=$(find /opt/homebrew/ -type f -name "diff-highlight" | head -n 1)
D=${DIFF_HIGHLIGHT}
if [ -e ${DIFF_HIGHLIGHT} ]; then
  export PATH=${PATH}:$(dirname ${DIFF_HIGHLIGHT})
  log_exist $N
else
  echo "${N} is not in /opt/homebrew/"
fi
