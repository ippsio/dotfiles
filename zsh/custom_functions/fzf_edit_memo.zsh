function memo() {
  #NOTE_TYPE=$(echo "memo\n最新状況\ntodo\n日報"|fzf --prompt="SELECT NOTE> ")
  # 面倒くせえからmemoと最新状況だけにした。
  NOTE_TYPE=$(echo "memo\n最新状況"|fzf --prompt="SELECT NOTE> ")
  echo "NOTE_TYPE=${NOTE_TYPE}"

  VALID_ARGS=("memo" "最新状況" "todo" "日報")
  if [[ -n ${VALID_ARGS[(re)$NOTE_TYPE]} ]]; then
    if [[ "${NOTE_TYPE}" == "最新状況" ]]; then
      NOTE_DIR=${ENV_ROOT_NOTES_DIR:-~/notes}/fixed
      TODAYS_NOTE_FILE=${NOTE_DIR}/${NOTE_TYPE}.md
      mkdir -p ${NOTE_DIR}
      [ ! -f ${TODAYS_NOTE_FILE} ] && echo "# ${NOTE_TYPE}\n---\n" >> ${TODAYS_NOTE_FILE}
      notefile=$(find ${ENV_ROOT_NOTES_DIR:-~/notes} -type f| fgrep "/fixed/" |sed -e "s#^${HOME}#~#"| sort -r | fzf --prompt="${NOTE_TYPE} >" --preview='bat $(echo {}| sed -e "s#^~#${HOME}#") --color=always'| sed -e "s#^~#${HOME}#")

    else
      YMDA=$(date '+%Y/%m/%d(%a)')
      NOTE_DIR=${ENV_ROOT_NOTES_DIR:-~/notes}/${NOTE_TYPE}/$(date '+%Y_%m')
      TODAYS_NOTE_FILE=${NOTE_DIR}/$(date '+%Y_%m%d_%a').md
      mkdir -p ${NOTE_DIR}
      [ ! -f ${TODAYS_NOTE_FILE} ] && echo "# ${YMDA}\n${NOTE_TYPE}\n---\n" >> ${TODAYS_NOTE_FILE}
      notefile=$(find ${ENV_ROOT_NOTES_DIR:-~/notes} -type f| fgrep "/${NOTE_TYPE}/" |sed -e "s#^${HOME}#~#"| sort -r | fzf --prompt="${NOTE_TYPE} >" --preview='bat $(echo {}| sed -e "s#^~#${HOME}#") --color=always'| sed -e "s#^~#${HOME}#")
    fi
    echo "FILE=$TODAYS_NOTE_FILE"
    if [[ "${notefile}" != "" ]]; then
      nvim ${notefile} +4
    fi
  else
    echo "args must be one of [$VALID_ARGS]."
  fi
}
