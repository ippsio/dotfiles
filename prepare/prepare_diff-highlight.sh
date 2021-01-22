#!/bin/sh
N="diff-highlight"
DIFF_HIGHLIGHT_DIR=/usr/local/share/git-core/contrib/diff-highlight
D=${DIFF_HIGHLIGHT_DIR}
if [ ! -e ${D} ]; then
  log_not_exist $N $D
  echo "手動でコピーして。"
else
  log_exist $N $D
fi
if [ -e ${DIFF_HIGHLIGHT_DIR}/diff-highlight ]; then
  export PATH=${PATH}:${DIFF_HIGHLIGHT_DIR}
  echo "${DIFF_HIGHLIGHT_DIR}/diff-highlight is added into PATH"
else
  echo "${DIFF_HIGHLIGHT_DIR}/diff-highlight is not added into PATH"
fi
