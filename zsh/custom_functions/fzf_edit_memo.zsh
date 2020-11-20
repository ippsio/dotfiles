function memo() {
  #NOTE_TYPE=$(echo "memo\ntodo\n日報"|fzf --prompt="SELECT NOTE> ")
  # 面倒くせえからmemo一択にした。
  NOTE_TYPE=memo
  echo "NOTE_TYPE=${NOTE_TYPE}"

  VALID_ARGS=("memo" "todo" "日報")
  if [[ -n ${VALID_ARGS[(re)$NOTE_TYPE]} ]]; then
    YMDA=$(date '+%Y/%m/%d(%a)')
    NOTE_DIR=${ENV_ROOT_NOTES_DIR:-~/notes}/${NOTE_TYPE}/$(date '+%Y_%m')
    TODAYS_NOTE_FILE=${NOTE_DIR}/$(date '+%Y_%m%d').md
    echo "FILE=$TODAYS_NOTE_FILE"
    mkdir -p ${NOTE_DIR}
    [ ! -f ${TODAYS_NOTE_FILE} ] && echo "# ${YMDA}\n${NOTE_TYPE}\n---\n" >> ${TODAYS_NOTE_FILE}
    notefile=$(find ${ENV_ROOT_NOTES_DIR:-~/notes}/ -type f| fgrep "${NOTE_TYPE}" |sort -r | fzf --prompt="${NOTE_TYPE} >" --preview='bat {} --color=always')
    if [[ "${notefile}" != "" ]]; then
      nvim ${notefile} +4
    fi
  else
    echo "args must be one of [$VALID_ARGS]."
  fi
}
