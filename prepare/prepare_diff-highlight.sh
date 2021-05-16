#!/bin/sh
N="diff-highlight"
DIFF_HIGHLIGHT_DIR=echo $(find /opt/homebrew -type f -name "diff-highlight") | head -n 1)
D=${DIFF_HIGHLIGHT_DIR}
if [ -e ${DIFF_HIGHLIGHT_DIR}/diff-highlight ]; then
  export PATH=${PATH}:${DIFF_HIGHLIGHT_DIR}
  log_exist $N
else
  echo "${N} is not /opt/homebrew/"
fi
