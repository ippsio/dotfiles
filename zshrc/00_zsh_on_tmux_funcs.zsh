#!/usr/bin/env zsh
already_on_tmux() {
  [[ -n "$TMUX" ]]
}

is_ps1_present() {
  [[ -n "$PS1" ]]
}

tmux_available() {
  already_on_tmux && return 1
  is_ps1_present || return 1
  tmux_command_exists || return 1
  return 0
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
  [[ -z "$i" ]] || return 1
  if tmux attach-session -t "$i"; then
    tmux_wait_for_bye
    return 0
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

tmux_command_exists() {
  type "tmux">/dev/null 2>&1
}

