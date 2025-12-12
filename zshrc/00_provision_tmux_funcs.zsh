#!/usr/bin/env zsh
TMUX_LOG_DIR="$HOME/.tmux/log"

not_on_tmux_yet() {
  [[ -z "$TMUX" ]]
}

is_ps1_absent() {
  [[ -z "$PS1" ]]
}

tmux_usable_environment() {
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
    return 0
  else
    return 1
  fi
}
tmux_session_new() {
  local i=$(tmux_idx_next_new)
  tmux new-session -s "$i"
  return 0
}

tmux_wait_for_bye() {
  for i in 3 2 1 "bye"; do echo "$i"; sleep 0.5; done
  return 0
}

tmux_command_not_found() {
  type "tmux">/dev/null 2>&1 && return 1 || return 0
}
tmux_logfile_path() {
  local dt="$(date +%Y-%m-%d_%H%M%S.%s)"
  local logfile_path="$TMUX_LOG_DIR/$dt.log"
  logfile_path=${logfile_path/$HOME/\$HOME}
  echo "$logfile_path"
}
start_tmux_logging() {
  local logfile_path="$1"
  echo "tmux_logfile_path=$logfile_path"
  tmux pipe-pane "$HOME/dotfiles/zshrc/00_provision_tmux_log_gawk.zsh >> $logfile_path"
}
