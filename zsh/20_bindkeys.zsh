# emacs like
bindkey -e

fzf_pick_git_branch() {
  fixed="-- \n-- .\n-b "
  dynamic="$(git branch -a| sed -e 's/^[\* ]*//' | sed -e 's/^[ ]*//g'| sort)"
  candidates="${fixed}\n${dynamic}"

  # See https://git-scm.com/docs/git-log for more details!
  # git log options
  #   %H  コミットのハッシュ
  #   %h  コミットのハッシュ (短縮版)
  #   %T  ツリーのハッシュ
  #   %t  ツリーのハッシュ (短縮版)
  #   %P  親のハッシュ
  #   %p  親のハッシュ (短縮版)
  #   %an Author の名前
  #   %ae Author のメールアドレス
  #   %ad Author の日付 (-date= オプションに従った形式)
  #   %ar Author の相対日付
  #   %cn Committer の名前
  #   %ce Committer のメールアドレス
  #   %cd Committer の日付
  #   %cr Committer の相対日付
  #   %s  件名
  #
  # git log date formats
  #   --date=iso       # ISO 8601フォーマット
  #   --date=relative  # 相対時間 (3 days ago)
  #   --date=local     # ローカルタイムゾーン
  #   --date=iso       # ISO 8601 フォーマット
  #   --date=rfc       # RFC 2822 フォーマット
  #   --date=short     # YYYY-MM-DD
  #   --date=raw       # %s %z
  #   --date=default   # 標準
  #   --date=format:'%Y/%m/%d %H:%M:%S'       # 任意のフォーマット
  #   --date=format-local:'%Y/%m/%d %H:%M:%S' # 任意のフォーマットをローカルタイムゾーンで

  local commit_hash="%Cred%h%Creset"
  local author="%C(bold blue)%an%Creset"
  local subject="%s"
  local commit_date="%Cgreen(%cd)%Creset"
  local ref_names="%C(yellow)%d%Creset"

  local CMD="git log"
  local CMD="${CMD} --graph"
  local CMD="${CMD} --color=always"
  local CMD="${CMD} --date=format-local:'%Y/%m/%d %H:%M:%S'"
  local CMD="${CMD} --pretty=format:'${commit_hash}${commit_date} ${author}${ref_names} ${subject}'"
  local CMD="${CMD} --abbrev-commit"
  local CMD="${CMD} {}"
  echo ${candidates} \
    | fzf --prompt='git checkout> ' \
    --preview "echo {}; echo; ${CMD}" \
    --preview-window=right:70%:wrap \
    | sed -e "s/^[\* ]*//" \
    | sed -e "s/^remotes\/origin\///"
}

# スペースでよく使うコマンドを展開
function _space_extraction() {
  #printf "BUFFER=[${BUFFER}] LBUFFER=[${LBUFFER}] RBUFFER=[${RBUFFER}]\n"

  # globalaliasの展開
  # NOTE: 一般的に大文字が使われるらしいので、ここでも大文字（と数字）でのみチェックしている。
  [[ $LBUFFER =~ ' [A-Z0-9]+$' ]] && zle _expand_alias

  # git
  [[ $BUFFER =~ '^g+$' ]]            && BUFFER="git " && zle end-of-line && return
  # git diff for short
  [[ $BUFFER =~ '^git di+$' ]]       && BUFFER="git diff " && zle end-of-line && return
  # git status for short
  [[ $BUFFER =~ '^gs+$' ]]           && BUFFER="git status -sb " && zle end-of-line && return
  [[ $BUFFER =~ '^git st+$' ]]       && BUFFER="git status " && zle end-of-line && return
  # git checkout completion
  [[ $BUFFER =~ '^gco+$' ]]          && BUFFER="git checkout $(fzf_pick_git_branch)" && zle end-of-line && return
  [[ $BUFFER =~ '^git co+$' ]]       && BUFFER="git checkout $(fzf_pick_git_branch)" && zle end-of-line && return
  [[ $BUFFER =~ '^git checkout+$' ]] && BUFFER="git checkout $(fzf_pick_git_branch)" && zle end-of-line && return
  # git fetch origin --prune for short
  [[ $BUFFER =~ '^gfo+$' ]]          && BUFFER="git fetch origin --prune " && zle end-of-line && return
  [[ $BUFFER =~ '^git fo+$' ]]       && BUFFER="git fetch origin --prune " && zle end-of-line && return
  # git merge for short
  [[ $BUFFER =~ '^gme+$' ]]          && BUFFER="git merge " && zle end-of-line && return
  [[ $BUFFER =~ '^git me+$' ]]       && BUFFER="git merge " && zle end-of-line && return
  # git push origin HEAD for short
  [[ $BUFFER =~ '^gps+$' ]]          && BUFFER="git push origin HEAD " && zle end-of-line && return
  [[ $BUFFER =~ '^git ps+$' ]]       && BUFFER="git push origin HEAD " && zle end-of-line && return
  # bundle exec for short
  [[ $BUFFER =~ '^be+$' ]]   && BUFFER="bundle exec " && zle end-of-line && return
  # bundle exec rails c for short
  [[ $BUFFER =~ '^c+$' ]]    && BUFFER="bundle exec rails c" && zle end-of-line && return
  [[ $BUFFER =~ '^rc+$' ]]   && BUFFER="bundle exec rails c" && zle end-of-line && return
  [[ $BUFFER =~ '^berc+$' ]] && BUFFER="bundle exec rails c" && zle end-of-line && return
  # bundle exec rails s for short
  [[ $BUFFER =~ '^rs+$' ]]   && BUFFER="bundle exec rails s -b 0.0.0.0" && zle end-of-line && return
  [[ $BUFFER =~ '^bers+$' ]] && BUFFER="bundle exec rails s -b 0.0.0.0" && zle end-of-line && return
  # dockero-compose for short
  [[ $BUFFER =~ '^dc+$' ]] && BUFFER="docker-compose " && zle end-of-line && return
  zle self-insert
}
zle -N _space_extraction
bindkey " " _space_extraction

fzf_list_dir() {
  find $1 \
    -path '*/\.' -prune -o \
    -path '*/\.git' -prune -o -type d \
    | sed -e 's#$#/#g' \
    | sed -e 's#\/\/*#\/#g' \
    | fzf +m \
    --prompt=${1/${HOME}/'~'} \
    --preview 'echo -n $(cd {}; pwd); echo '/'; echo; ls -UlaFG {}' \
    --preview-window=right:60%:wrap || echo $1
}

fzf_list_file() {
  find $1 \
    -path '*/\.' -prune -o \
    -path '*/\.git' -prune -o \
    -type f \
    | sed -e 's#\/\/*#\/#g' \
    | fzf +m \
    --prompt=${1/${HOME}/'~'} \
    --preview 'bat --color=always --style=header,grid --line-range :100 {}' \
    --preview-window=right:60%:wrap || echo $1
#--preview 'ls -d {}; echo; bat {}' \
#--preview 'ls -d {}; echo; bat --color=always --style=header,grid --line-range :100 {}' \
}

# TAB(=CTRL+I)補完
function _tab_completion() {
  # cd にfzfで補完候補を付ける
  [[ $BUFFER =~ '^cd *$' ]] && BUFFER="cd ./" && zle end-of-line # zle end-of-lineの後に && returnしないのは意図的
  [[ $BUFFER =~ '^cd *.+/+$' ]] && BUFFER="cd $(fzf_list_dir ${${BUFFER#cd }:-.})" && zle end-of-line && return

  # vim にfzfで補完候補を付ける
  [[ $BUFFER =~ '^vim *$' ]] && BUFFER="vim ./" && zle end-of-line # zle end-of-lineの後に && returnしないのは意図的
  [[ $BUFFER =~ '^vim *.+/+$' ]] && BUFFER="vim $(fzf_list_file ${${BUFFER#vim }:-.})" && zle end-of-line && return

  # 上記にヒットしなかたら、普通っぽい挙動にする
  zle expand-or-complete
}

# TAB(=CTRL+I)補完
zle -N _tab_completion
bindkey "^I" _tab_completion

# ^で一つ上のフォルダへ移動
function hat_cdup () { [[ ${BUFFER} == "" ]] && cd .. && zle accept-line && zle reset-prompt && return || zle self-insert }
zle -N hat_cdup
bindkey "\^" hat_cdup

# CTRL-D,DELで前方削除
bindkey "^[[3~" delete-char

