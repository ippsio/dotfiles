alias ll='ls -Ulah'
alias ls='ls -G'
alias vim='nvim'
alias v='nvim'
function _todays_memo() {
  MEMO_NAME=$1
  YMDA=$(date '+%Y/%m/%d(%a)')
  DIR=~/${MEMO_NAME}/$(date '+%Y_%m')
  FILE=${DIR}/$(date '+%Y_%m%d').md
  mkdir -p ${DIR}
  [ ! -f ${FILE} ] && echo "# ${YMDA}\n${MEMO_NAME}\n---\n" >> ${FILE}
  nvim ${FILE} +4
}
alias m="_todays_memo memo"
alias n"=_todays_memo note"

# global arial
alias -g D='-w --reverse $(git merge-base develop HEAD)...HEAD'
