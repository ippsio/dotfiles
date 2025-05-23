#!/usr/bin/env zsh
am_not_i_on_tmux() {
  if [[ -z "$TMUX" && -n "$PS1" ]]; then
    return 0
  else
    return 1
  fi
}

tmux_idx_next_attach() {
  tmux ls -f "#{==:#{session_attached},0}" -F "#S"\
    | sort --general-numeric-sort\
    | head -1
  return 0
}

tmux_idx_next_new() {
  (tmux ls -F "#S"; seq 1 16)\
    | sort --general-numeric-sort\
    | uniq --unique\
    | head -1
  return 0
}
tmux_session_attach() {
  i=$(tmux_idx_next_attach)
  if [[ -n "$i" ]] && tmux attach-session -t "$i" && tmux_wait_for_bye; then
    return 0
  else
    return 1
  fi
}
tmux_session_new() {
  i=$(tmux_idx_next_new)
  tmux new-session -s "$i"
  tmux_wait_for_bye
  return 0
}

tmux_wait_for_bye() {
  echo "bye"
  sleep 1
  return 0
}

tmux_executable() {
  if type "tmux" > /dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}
if tmux_executable && am_not_i_on_tmux; then
  tmux_session_new
  while true; do
    tmux_session_attach || exit
  done
fi
