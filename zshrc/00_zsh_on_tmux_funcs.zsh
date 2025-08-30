#!/usr/bin/env zsh
is_on_tmux() {
  if [[ -n "$TMUX" ]]; then
    return 0
  else
    return 1
  fi
}

is_ps1_absent() {
  if [[ -z "$PS1" ]]; then
    return 0
  else
    return 1
  fi
}

tmux_available() {
  if is_on_tmux; then
    return 1
  elif is_ps1_absent; then
    return 1
  elif tmux_command_not_exists; then
    return 1
  else
    return 0
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
  if [[ -n "$i" ]]; then
    if tmux attach-session -t "$i"; then
      tmux_wait_for_bye
      return 0
    fi
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

tmux_command_not_exists() {
  if type "tmux" > /dev/null 2>&1; then
    return 1
  else
    return 0
  fi
}

