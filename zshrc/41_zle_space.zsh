zle -N do_zle_space
bindkey " " do_zle_space

do_zle_space() {
  zle_space
  return 0
}

# スペースでよく使うコマンドを展開
zle_space() {
  expand_global_alias

  lbuf_subtract_rbuf_eval "de" "" "docker_ps_fzf_exec" && return 0
  lbuf_subtract_back "dej" 'deepl-cli-ej ""' && return 0
  lbuf_subtract_back "gej" 'gc-translate-cli-ej ""' && return 0
  lbuf_subtract_accept "i" "initvim" && return 0
  lbuf_subtract "rgg" "rg_fzf_vim " && return 0
  lbuf_subtract_rbuf_eval "scp " "scp " "fzf_ssh_config" && return 0
  lbuf_subtract_rbuf_eval "ssh " "ssh " "fzf_ssh_config" && return 0

  if $(is_git_repo); then
    lbuf_subtract "gfo" "git fetch origin --prune" && return 0

    lbuf_subtract "gg" "git_grep_fzf_vim " && return 0
    lbuf_subtract "git_grep_fzf_vim " "git_grep " && return 0
    lbuf_subtract "git_grep " "git grep " && return 0

    lbuf_subtract_rbuf_eval "gco" "git checkout " "git_branch_fzf" && return 0
    lbuf_subtract_rbuf_eval "git branch -M" "git branch -M " "git branch --show-current" && return 0

    lbuf_subtract "git co" "git checkout " && return 0
    lbuf_subtract "git log " "git log --date=iso --pretty='%h %ad %an %s' -1" && return 0
    lbuf_subtract "gme" "git merge --ff " && return 0
    lbuf_subtract "gps" "git push -u origin HEAD" && return 0
  fi

  if [[ -e Gemfile ]]; then
    lbuf_subtract "be" "bundle exec " && return 0
    lbuf_subtract "c" "bundle exec rails c" && return 0
    lbuf_subtract_rbuf_eval "rake" "bundle exec rake " "fzf_bundle_exec_rake" && return 0
    lbuf_subtract "rs" "bundle exec rails s -b 0.0.0.0" && return 0
    lbuf_subtract "sidekiq" "bundle exec sidekiq -C config/sidekiq.yml" && return 0
  fi

  for f in $(echo "docker-compose.yml"); do
    if [[ -e "$f" ]]; then
      str="docker-compose"
      if [[ "$f" != "docker-compose.yml" ]]; then
        str+=" -f $f"
      fi
      lbuf_subtract "dc" "$str " && return 0
      lbuf_subtract "dcu" "$str up -d" && return 0
      lbuf_subtract "dcul" "$str up -d; $str logs -f" && return 0
      lbuf_subtract "dcd" "$str down" && return 0
      lbuf_subtract "dcl" "$str logs -f" && return 0
      lbuf_subtract "dcp" "$str ps" && return 0
      break
    fi
  done
  zle self-insert
}
