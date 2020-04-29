#!/bin/sh
function log_exist() { echo "[o] exist! '$1'" }
function log_not_exist() { echo "------------\n[x] not found! '$1' " }

N="diff-highlight"
DIFF_HL_PATH=/usr/local/share/git-core/contrib/diff-highlight
D=${DIFF_HL_PATH}
if [ ! -e ${D} ]; then
  log_not_exist $N $D
  echo "手動でコピーして。"
else
  log_exist $N $D
fi
