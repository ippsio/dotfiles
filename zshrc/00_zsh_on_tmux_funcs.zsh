#!/usr/bin/env zsh
on_tmux() {
  [[ -n "$TMUX" ]]
}

is_ps1_absent() {
  [[ -z "$PS1" ]]
}

tmux_usable() {
  on_tmux && return 1
  is_ps1_absent && return 1
  tmux_command_not_found && return 1
  return 0
}

tmux_idx_next_attach() {
  tmux ls -f "#{==:#{session_attached},0}" -F "#S"| sort -n| head -1
  return 0
}

tmux_idx_next_new() {
  (
    tmux ls -F "#S" 2>/dev/null
    seq 1 16
  ) | sort --general-numeric-sort\
    | uniq --unique\
    | head -1
  return 0
}
tmux_session_attach() {
  local i=$(tmux_idx_next_attach)
  if [[ -z "$i" ]]; then
    return 1
  elif tmux attach-session -t "$i"; then
    tmux_wait_for_bye
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
  for i in $(seq 3 1); do echo "$i"; sleep 1; done
  echo "bye"
  sleep 1
  return 0
}

tmux_command_not_found() {
  type "tmux">/dev/null 2>&1 && return 1 || return 0
}

