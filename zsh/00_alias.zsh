alias ll='ls -Ulah'
alias ls='ls -G'
alias vim='nvim'
alias v='nvim'
function _todays_memo() {
  YMDA=$(date '+%Y/%m/%d(%a)')
  DIR=~/memo/$(date '+%Y_%m')
  FILE=${DIR}/$(date '+%Y_%m%d').md
  mkdir -p ${DIR}
  [ ! -f ${FILE} ] && echo "# ${YMDA}\n---\n" >> ${FILE}
  nvim ${FILE} +3
}
alias m=_todays_memo

# global arial
alias -g D='-w --reverse $(git merge-base develop HEAD)...HEAD'
