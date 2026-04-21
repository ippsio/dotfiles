#!/usr/bin/env bash
empty_or_dot_or_dot_slash() {
  if [[ -z "$1" || "$1" == "." || "$1" == "./" ]]; then
    return 0
  else
    return 1
  fi
}
get_target_dir_h_as_h() {
  if empty_or_dot_or_dot_slash "$1"; then
    echo "."
  else
    dir=$(home_as_home "${1#./}")
    if [[ ! -e "${dir}" ]]; then
      echo "$1"
      exit
    fi
    echo "$dir"
  fi
}
get_fzf_query() {
  if empty_or_dot_or_dot_slash "$1"; then
    echo ""
  else
    home_as_tilde "${1#./}"
  fi
}

