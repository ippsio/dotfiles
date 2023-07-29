#!/usr/bin/env zsh
zle_ctrl_g() {
  BUFFER_WAS=${BUFFER}

  # cd
  BUFFER="$(goto_candidate_fzf)"
  if [[ ! -z "${BUFFER}" ]]; then
    zle accept-line
    return 0
  else
    BUFFER=${BUFFER_WAS}
    return 1
  fi
  return 0
}

