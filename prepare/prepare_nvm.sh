#!/bin/bash
function log_exist() { echo "[o] exist! '$1'" }
function log_not_exist() { echo "------------\n[x] not found! '$1' " }

N="nvm"
D=${NVM_DIR}
if [ ! -d ${D} ]; then
  log_not_exist $N $D
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
  mkdir ${D}
else
  log_exist $N $D
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

