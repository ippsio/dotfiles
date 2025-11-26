zle -N do_zle_space
bindkey " " do_zle_space

do_zle_space() {
  zle_space
  return 0
}

# スペースでよく使うコマンドを展開
zle_space() {
  expand_global_alias

  isbuf "de" && v=$(rbufval "docker_ps_fzf_exec") && lbuf "" && rbuf "$v" && return 0
  isbuf "dej" && lbuf 'deepl-cli-ej ""' && zle backward-char && return 0
  isbuf "gej" && lbuf 'gc-translate-cli-ej ""' && zle backward-char && return 0
  isbuf "i" && lbuf "initvim" && zle accept-line && return 0
  isbuf "rgg" && lbuf "rg_fzf_vim " && return 0
  isbuf "scp " && v=$(fzf_ssh_config) && rbuf "$v" && return 0
  isbuf "ssh " && v=$(fzf_ssh_config) && rbuf "$v" && return 0

  if $(is_git_repo); then
    isbuf "b" && lbuf "git_branch_fzf " && return 0
    isbuf "gco" && lbuf "git checkout"
    isbuf "gfo" && lbuf "git fetch origin --prune" && return 0
    isbuf "gg" && lbuf "git_grep_fzf_vim " && return 0
    isbuf "git branch -M" && addsp && v=$(rbufval "git branch --show-current") && rbuf "$v" && return 0
    isbuf "git checkout" && addsp && v=$(rbufval "git_branch_fzf") && rbuf "$v" && return 0
    isbuf "git co" && lbuf "git checkout "
    isbuf "git log " && lbuf "git log --date=iso --pretty='%h %ad %an %s' -1" && return 0
    isbuf "git_grep " && lbuf "git grep " && return 0
    isbuf "git_grep_fzf_vim " && lbuf "git_grep " && return 0
    isbuf "gme" && lbuf "git merge --ff " && return 0
    isbuf "gps" && lbuf "git push -u origin HEAD" && return 0
  fi

  if [[ -e Gemfile ]]; then
    isbuf "be" && lbuf "bundle exec " && return 0
    isbuf "c" && lbuf "bundle exec rails c" && return 0
    isbuf "rake" && v=$(rbufval fzf_bundle_exec_rake) && lbuf "bundle exec rake " && rbuf "$v" && return 0
    isbuf "rs" && lbuf "bundle exec rails s -b 0.0.0.0" && return 0
    isbuf "sidekiq" && lbuf "bundle exec sidekiq -C config/sidekiq.yml" && return 0
  fi

  for f in $(echo "docker-compose-m1.yml docker-compose.yml docker-compose-full-container.yml"); do
    if [[ -e "$f" ]]; then
      str="docker-compose"
      if [[ "$f" != "docker-compose.yml" ]]; then
        str+=" -f $f"
      fi
      isbuf "dc" && lbuf "$str " && return 0
      isbuf "dcu" && lbuf "$str up -d" && return 0
      isbuf "dcul" && lbuf "$str up -d; $str logs -f" && return 0
      isbuf "dcd" && lbuf "$str down" && return 0
      isbuf "dcl" && lbuf "$str logs -f" && return 0
      isbuf "dcp" && lbuf "$str ps" && return 0
      break
    fi
  done
  zle self-insert
}
