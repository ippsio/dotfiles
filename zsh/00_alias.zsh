alias ll='ls -Ulah'
alias ls='ls -G'
alias vim='nvim'
alias v='nvim'

function memo() {
  NOTE_TYPE=${1:-memo}
  echo "NOTE_TYPE=${NOTE_TYPE}"

  VALID_ARGS=("memo" "note" "todo")
  if [[ -n ${VALID_ARGS[(re)$NOTE_TYPE]} ]]; then
    YMDA=$(date '+%Y/%m/%d(%a)')
    NOTE_DIR=${ENV_ROOT_NOTES_DIR:-~/notes}/${NOTE_TYPE}/$(date '+%Y_%m')
    NOTE_FILE=${NOTE_DIR}/$(date '+%Y_%m%d').md
    echo "FILE=$NOTE_FILE"
    mkdir -p ${NOTE_DIR}
    [ ! -f ${NOTE_FILE} ] && echo "# ${YMDA}\n${NOTE_TYPE}\n---\n" >> ${NOTE_FILE}
    nvim ${NOTE_FILE} +4
  else
    echo "args must be one of [$VALID_ARGS]."
  fi
}
alias m="memo"
alias n"=memo note"
alias todo"=memo todo"

# global arial
alias -g D='-w --reverse $(git merge-base develop HEAD)...HEAD'
