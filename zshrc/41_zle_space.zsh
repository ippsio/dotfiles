# スペースでよく使うコマンドを展開
zle_space() {
  #printf "BUFFER=[${BUFFER}] LBUFFER=[${LBUFFER}] RBUFFER=[${RBUFFER}]\n"

  # globalaliasの展開
  # NOTE: 一般的に大文字が使われるらしいので、ここでも大文字（と数字）でのみチェックしている。
  [[ $LBUFFER =~ ' [A-Z0-9]+$' ]] \
  && zle _expand_alias

  # cd
  if [[ $BUFFER =~ '^goto+$' || $BUFFER =~ '^g$' ]]; then
    BUFFER="$(goto_candidate_fzf)"
    if [[ ! -z "${BUFFER}" ]]; then
      zle accept-line
      return 0
    else
      BUFFER=""
      return 1
    fi
  fi

  # ssh
  [[ $BUFFER =~ '^ssh+[ ]$' ]] \
  && BUFFER="ssh $(fgrep 'Host ' ~/.ssh/config | grep -v '*' | awk '{print $2}' | sort | fzf)" \
  && zle end-of-line && return 0

  # scp
  [[ $BUFFER =~ '^scp+[ ]$' ]] \
  && BUFFER="scp $(fgrep 'Host ' ~/.ssh/config | grep -v '*' | awk '{print $2}' | sort | fzf)" \
  && zle end-of-line && return 0

  # git grep(git_grep_fzf_vimでは、git管理外でも検索できるよう、-c grep.fallbackToNoIndex=true 付きにしてあります。)
  [[ $BUFFER =~ '^gg' ]] \
    && BUFFER="git_grep_fzf_vim ${RBUFFER}" && zle end-of-line && return 0

  if $(is_git_repo); then
    [[ $BUFFER =~ '^git_grep_fzf_vim +$' ]] \
      && BUFFER="git_grep " && zle end-of-line && return 0

    # git checkout + completion
    [[ $BUFFER =~ '^gco+$' ]] \
    && zle autosuggest-clear && BUFFER="git checkout $(git_branch_fzf)" && zle end-of-line && return 0

    # git branch + completion
    [[ $BUFFER =~ '^b+$' ]] \
    && zle autosuggest-clear \
    && BUFFER="git_branch_fzf" \
    && zle end-of-line \
    && BUFFER="$(git_branch_fzf)" \
    && zle end-of-line && return 0

    # git branch + completion
    [[ $BUFFER =~ '^.*B+$' ]] \
    && zle autosuggest-clear \
    && zle end-of-line \
    && BUFFER="${BUFFER%B}$(git_branch_fzf)" \
    && zle end-of-line && return 0

    # git fetch origin --prune
    [[ $BUFFER =~ '^gfo+$' ]] \
    && BUFFER="git fetch origin --prune" && zle end-of-line && return 0

    # git fetch origin $(git branch --show-current 2>/dev/null)
    [[ $BUFFER =~ '^git fetch origin --prune+$' ]] \
    && BUFFER="git fetch origin $(git branch --show-current 2>/dev/null)" && zle end-of-line && return 0

    # git merge
    [[ $BUFFER =~ '^gme+$' ]] \
    && BUFFER="git merge --ff" && zle end-of-line && return 0

    # git push origin HEAD
    [[ $BUFFER =~ '^gps+$' ]] \
    && BUFFER="git push origin HEAD " && zle end-of-line && return 0

    # git_deep_blame
    [[ $BUFFER =~ '^gb+$' ]] \
    && BUFFER="git_deepblame " && zle end-of-line && return 0
  fi

  # bundle exec
  [[ $BUFFER =~ '^be+$' ]] \
  && BUFFER="bundle exec " && zle end-of-line && return 0

  # bundle exec rails
  [[ $BUFFER =~ '^rails+$' ]] \
  && BUFFER="bundle exec rails " && zle end-of-line && return 0

  # bundle exec rails c
  [[ $BUFFER =~ '^c+$' ]] \
  && BUFFER="bundle exec rails c" && zle end-of-line && return 0

  # bundle exec rails c
  [[ $BUFFER =~ '^sidekiq+$' ]] \
  && BUFFER="bundle exec sidekiq -C config/sidekiq.yml" && zle end-of-line && return 0

  #  bundle exec rake + completion
  [[ $BUFFER =~ '^rake+$' ]] \
  && BUFFER="bundle exec rake $(fzf_bundle_exec_rake)" && zle end-of-line && return 0

  # bundle exec rails s
  [[ $BUFFER =~ '^rs+$' ]] \
  && BUFFER="bundle exec rails s -b 0.0.0.0" && zle end-of-line && return 0

  # rg
  [[ $BUFFER =~ '^rgg+$' ]] \
  && BUFFER="rg_fzf_vim " && zle end-of-line && return 0

  # docker exec
  [[ $BUFFER =~ '^de+$' || $BUFFER =~ '^docker exec+$' ]] \
  && BUFFER=$(docker_exec) && zle end-of-line && return 0

  # docker-compose
  dc_files=()
  dc_files+=(docker-compose-m1.yml)
  dc_files+=(docker-compose_m1.yml)
  dc_files+=(docker-compose-arm.yml)
  dc_files+=(docker-compose_arm.yml)
  dc_files+=(docker-compose.yml)
  for dc_file in ${dc_files}; do
    if [[ -e ${dc_file} ]]; then
      if [[ "${dc_file}" == "docker-compose.yml" ]]; then
        docker_compose="docker-compose"
      else
        docker_compose="docker-compose -f ${dc_file}"
      fi
      # docker-compose
      [[ $BUFFER =~ '^dc+$' ]] && BUFFER="${docker_compose} " && zle end-of-line && return 0

      # docker-compose up -d
      [[ $BUFFER =~ '^dcu+$' ]] && BUFFER="${docker_compose} up -d" && zle end-of-line && return 0

      # docker-compose up -d; docker-compose logs -f
      [[ $BUFFER =~ '^dcul+$' ]] && BUFFER="${docker_compose} up -d; ${docker_compose} logs -f" && zle end-of-line && return 0

      # docker-compose down
      [[ $BUFFER =~ '^dcd+$' ]] && BUFFER="${docker_compose} down" && zle end-of-line && return 0

      # docker-compose logs -f
      [[ $BUFFER =~ '^dcl+$' ]] && BUFFER="${docker_compose} logs -f" && zle end-of-line && return 0

      # docker-compose ps
      [[ $BUFFER =~ '^dcp+$' ]] && BUFFER="${docker_compose} ps" && zle end-of-line && return 0
    fi
  done

  zle self-insert
  return 1
}

