#!/usr/bin/env zsh
zle_ctrl_f() {
  BUFFER_WAS=${BUFFER}
  ARG=""
  if [[ ! -z "${LBUFFER// /}" ]]; then
    CHUNK="$(echo "${LBUFFER}"| awk '{ print $NF }')" # awk '{ print $NF }'=最後の要素
    if ( ! type "${CHUNK}" > /dev/null 2>&1 ); then
      # CHUNK はコマンドじゃない場合。つまりlsとかvimとかpythonとか、実行できるようなものじゃない場合。
      LBUFFER=$(echo "${LBUFFER}"| awk '{ NF--; print }')  # 先頭から最後-1番目までの全要素
      ARG="${CHUNK}"
    fi
  fi

  COMPLETION=$(fzf_list_file ${ARG})

  if [[ -z "${COMPLETION}" ]]; then
    BUFFER="${BUFFER_WAS}"
  else
    if [[ -d "${COMPLETION}" ]]; then
      COMPLETION=$(echo "${COMPLETION}"| sed -r 's#/{2,}#/#') # 2連以上のスラッシュは1個に。
      COMPLETION=$(echo "${COMPLETION}"| sed -r 's#/{1,}$##') # 末尾のスラッシュを削除。
      BUFFER="${LBUFFER} ${COMPLETION}/${RBUFFER}"
    else
      BUFFER="${LBUFFER} ${COMPLETION} ${RBUFFER}"
    fi
  fi
  zle end-of-line
  return 0
}

