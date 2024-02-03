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
    [[ -n "${BUFFER}" ]] && zle accept-line || BUFFER=""
    return 0
  fi

  # ssh
  if [[ $BUFFER =~ '^ssh+[ ]$' ]]; then
    BUFFER="ssh $(fgrep 'Host ' ~/.ssh/config | grep -v '*' | awk '{print $2}' | sort | fzf)" && zle end-of-line
    return 0
  fi

  # scp
  if [[ $BUFFER =~ '^scp+[ ]$' ]]; then
    BUFFER="scp $(fgrep 'Host ' ~/.ssh/config | grep -v '*' | awk '{print $2}' | sort | fzf)" && zle end-of-line
    return 0
  fi

  # git grep(git_grep_fzf_vimでは、git管理外でも検索できるよう、-c grep.fallbackToNoIndex=true 付きにしてあります。)
  if [[ $BUFFER =~ '^gg' ]]; then
    BUFFER="git_grep_fzf_vim ${RBUFFER}" && zle end-of-line
    return 0
  fi

  if $(is_git_repo); then
    if [[ $BUFFER =~ '^git_grep_fzf_vim +$' ]]; then
      BUFFER="git_grep " && zle end-of-line
      return 0
    fi

    # git checkout + completion
    if [[ $BUFFER =~ '^gco+$' ]]; then
      zle autosuggest-clear && BUFFER="git checkout $(git_branch_fzf)" && zle end-of-line
      return 0
    fi

    # git branch + completion
    if [[ $BUFFER =~ '^b+$' ]]; then
      zle autosuggest-clear\
        && BUFFER="git_branch_fzf" && zle end-of-line\
        && BUFFER="$(git_branch_fzf)" && zle end-of-line
      return 0
    fi

    # git branch + completion
    if [[ $BUFFER =~ '^.*B+$' ]]; then
      zle autosuggest-clear\
        && zle end-of-line\
        && BUFFER="${BUFFER%B}$(git_branch_fzf)"\
        && zle end-of-line
      return 0
    fi

    # git branch -M
    if [[ $BUFFER =~ '^git branch -M+$' ]]; then
      zle autosuggest-clear\
        && zle end-of-line\
        && BUFFER="${BUFFER%B} $(git branch --show-current)"\
        && zle end-of-line
      return 0
    fi

    # git fetch origin --prune
    if [[ $BUFFER =~ '^gfo+$' ]]; then
      BUFFER="git fetch origin --prune" && zle end-of-line
      return 0
    fi

    # git fetch origin $(git branch --show-current 2>/dev/null)
    if [[ $BUFFER =~ '^git fetch origin --prune+$' ]]; then
      BUFFER="git fetch origin $(git branch --show-current 2>/dev/null)" && zle end-of-line
      return 0
    fi

    # git merge
    if [[ $BUFFER =~ '^gme+$' ]]; then
      BUFFER="git merge --ff" && zle end-of-line
      return 0
    fi

    # git push origin HEAD
    if [[ $BUFFER =~ '^gps+$' ]]; then
      BUFFER="git push origin HEAD " && zle end-of-line
      return 0
    fi


    # git_deep_blame
    if [[ $BUFFER =~ '^gb+$' ]]; then
      BUFFER="git_deepblame " && zle end-of-line
      return 0
    fi

    # git_checkout
    if [[ $BUFFER =~ '^git[ ]*co$' ]]; then
      BUFFER="git checkout " && zle end-of-line
      return 0
    fi
  fi

  # bundle exec
  if [[ $BUFFER =~ '^be+$' ]]; then
    BUFFER="bundle exec " && zle end-of-line
    return 0
  fi

  # bundle exec rails
  if [[ $BUFFER =~ '^rails+$' ]]; then
    BUFFER="bundle exec rails " && zle end-of-line
    return 0
  fi

  # bundle exec rails c
  if [[ $BUFFER =~ '^c+$' ]]; then
    BUFFER="bundle exec rails c" && zle end-of-line
    return 0
  fi

  # bundle exec rails c
  if [[ $BUFFER =~ '^sidekiq+$' ]]; then
    BUFFER="bundle exec sidekiq -C config/sidekiq.yml" && zle end-of-line
    return 0
  fi

  #  bundle exec rake + completion
  if [[ $BUFFER =~ '^rake+$' ]]; then
    BUFFER="bundle exec rake $(fzf_bundle_exec_rake)" && zle end-of-line
    return 0
  fi

  # bundle exec rails s
  if [[ $BUFFER =~ '^rs+$' ]]; then
    BUFFER="bundle exec rails s -b 0.0.0.0" && zle end-of-line
    return 0
  fi

  # rg
  if [[ $BUFFER =~ '^rgg+$' ]]; then
    BUFFER="rg_fzf_vim " && zle end-of-line
    return 0
  fi

  # docker exec
  if [[ $BUFFER =~ '^de+$' || $BUFFER =~ '^docker exec+$' ]]; then
    BUFFER=$(docker_exec) && zle end-of-line
    return 0
  fi

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
      if [[ $BUFFER =~ '^dc+$' ]]; then
        BUFFER="${docker_compose} " && zle end-of-line
        return 0
      fi

      # docker-compose up -d
      if [[ $BUFFER =~ '^dcu+$' ]]; then
        BUFFER="${docker_compose} up -d" && zle end-of-line
        return 0
      fi

      # docker-compose up -d; docker-compose logs -f
      if [[ $BUFFER =~ '^dcul+$' ]]; then
        BUFFER="${docker_compose} up -d; ${docker_compose} logs -f" && zle end-of-line
        return 0
      fi

      # docker-compose down
      if [[ $BUFFER =~ '^dcd+$' ]]; then
        BUFFER="${docker_compose} down" && zle end-of-line
        return 0
      fi

      # docker-compose logs -f
      if [[ $BUFFER =~ '^dcl+$' ]]; then
        BUFFER="${docker_compose} logs -f" && zle end-of-line
        return 0
      fi

      # docker-compose ps
      if [[ $BUFFER =~ '^dcp+$' ]]; then
        BUFFER="${docker_compose} ps" && zle end-of-line
        return 0
      fi
    fi
  done

  zle self-insert
  return 1
}
