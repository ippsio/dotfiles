function memo() {
  NOTES_DIR=~/notes
  [ ! -d ${NOTES_DIR} ] && mkdir -p ${NOTES_DIR} && echo "maybe ${NOTES_DIR} created."
  while true;
  do
    #NOTE_TYPE=$(echo "memo\n最新状況\ntodo\n日報"|fzf --prompt="SELECT NOTE> ")
    # 面倒くせえからmemoと最新状況だけにした。
    NOTE_TYPE=$(echo "memo\n最新状況"|fzf --prompt="SELECT NOTE> ")
    [[ ${NOTE_TYPE} == "" ]] && return

    VALID_ARGS=("memo" "最新状況" "todo" "日報")
    if [[ "${NOTE_TYPE}" == "最新状況" ]]; then
      POSTFIX=fixed
      NOTE_DIR=${NOTES_DIR}/${POSTFIX}
      mkdir -p ${NOTE_DIR}
      TODAYS_NOTE_FILE=${NOTE_DIR}/${NOTE_TYPE}.md
      [ ! -f ${TODAYS_NOTE_FILE} ] && echo "# ${NOTE_TYPE}\n---\n" >> ${TODAYS_NOTE_FILE}
      notefile=$(find ${NOTES_DIR} -type f \
        | fgrep "/fixed/" \
        | sed -e "s#^${HOME}#~#" \
        | sort -r \
        | fzf --prompt="${NOTE_TYPE} >"  \
          --bind change:top \
          --bind 'enter:execute(nvim $(echo {}| sed -e "s#^~#${HOME}#") < /dev/tty > /dev/tty)' \
          --preview='bat $(echo {}| sed -e "s#^~#${HOME}#") --color=always'| sed -e "s#^~#${HOME}#" \
        )
    else
      POSTFIX=${NOTE_TYPE}/$(LC_ALL=C date '+%Y_%m')
      YMDA=$(LC_ALL=C date '+%Y/%m/%d(%a)')
      NOTE_DIR=${NOTES_DIR}/${POSTFIX}
      mkdir -p ${NOTE_DIR}
      TODAYS_NOTE_FILE=${NOTE_DIR}/$(LC_ALL=C date '+%Y_%m%d_%a').md
      [ ! -f ${TODAYS_NOTE_FILE} ] && echo "# ${YMDA}\n${NOTE_TYPE}\n---\n" >> ${TODAYS_NOTE_FILE}
      notefile=$(find ${NOTES_DIR} -type f \
        | fgrep "/${NOTE_TYPE}/" \
        | sed -e "s#^${HOME}#~#" \
        | sort -r \
        | fzf --prompt="${NOTE_TYPE} >"  \
          --bind change:top \
          --bind 'enter:execute(nvim $(echo {}| sed -e "s#^~#${HOME}#") < /dev/tty > /dev/tty)' \
          --preview='bat $(echo {}| sed -e "s#^~#${HOME}#") --color=always'|  \
        sed -e "s#^~#${HOME}#" \
      )
    fi
    if ( ! (cd ${NOTES_DIR} && [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1) ); then
      echo "[${NOTES_DIR}] is not seems to note git repo."
      echo "Consider about 'git init' on [${NOTES_DIR}]"
    else
      if [ $(cd ${NOTES_DIR} && git status --porcelain 2>&1 > /dev/null | wc -l| tr -d ' ') -gt 0 ]; then
        echo "変更有り。"
        echo $(cd ${NOTES_DIR} && git add -A && echo $(git commit -m "$(date '+%Y/%m/%d(%a) %H時%M分%S秒')"))
      fi
    fi
  done
}

