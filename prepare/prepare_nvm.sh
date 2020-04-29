#!/bin/bash
# ---------------------------------------------------------------------------------------------------------------------
N="nvm"
D=${NVM_DIR}
if [ ! -d ${D} ]; then
  log_not_exist $N $D
  brew install nvm
  mkdir ${D}
else
  log_exist $N $D
fi
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

