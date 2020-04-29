#!/bin/bash
# ---------------------------------------------------------------------------------------------------------------------
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

