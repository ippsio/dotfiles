autoload -Uz add-zsh-hook
find_up() {
  local dir
  dir=$PWD
  while [[ $dir != "/" ]]; do
    [[ -e $dir/$1 ]] && { echo $dir/$1; return 0; }
    dir=${dir:h}
  done
  return 1
}

git_prompt() {
  local gitdir
  gitdir="$(find_up .git)"
  if [[ -n "$gitdir" ]]; then
    t0=${${EPOCHREALTIME/./}[1,13]}
    local untracked=0 unstaged=0 staged=0 unmerged=0 conflict=0 ahead=0 behind=0 stash=0
    local porcelain
    porcelain=$(git status --porcelain=v2 --branch --show-stash 2>/dev/null || return 1)
    t1=${${EPOCHREALTIME/./}[1,13]}
    local line
    while IFS= read -r line; do
      case "$line" in
        "# branch.ab"*)
          ahead=${line#*+}
          ahead=${ahead%% *}
          behind=${line#*-}
          behind=${behind%% *}
          ;;
        "# stash"*)
          stash=${line##* }
          ;;
        "1 "*)
          local xy_for_1=${line:2:2}
          case "$xy_for_1" in
            " M" ) ((unstaged++)) ;; # 未ステージングの変更がある。
            ".M" ) ((unstaged++)) ;; # 未ステージングの変更がある（ M と同義）。
            "M " ) ((staged++)) ;; # ステージング済みの変更のみがある。
            "M." ) ((staged++)) ;; # ステージング済みの変更のみがある（M  と同義）。
            "MM" ) ((staged++)); ((unstaged++)) ;; # ステージング済みの変更と、未ステージングの変更の両方がある。
            " A" )  ;; # $Y$ が A は追跡ファイルでは非常に稀（通常は $X$ が A）。実質的に ?? に近い状態。
            ".A" )  ;; # $Y$ が A は追跡ファイルでは非常に稀（通常は $X$ が A）。
            "A " ) ((staged++)) ;; # ステージング済みの追加がある。
            "A." ) ((staged++)) ;; # ステージング済みの追加がある（A  と同義）。
            "AM" ) ((staged++)); ((unstaged++)) ;; # ステージング済みの追加と、未ステージングの変更の両方がある。
            "AD" ) ((staged++)); ((unstaged++)) ;; # ステージング済みの追加と、ワークツリーでの削除がある。
            " D" ) ((unstaged++)) ;; # 未ステージングの削除がある。
            ".D" ) ((unstaged++)) ;; # 未ステージングの削除がある（ D と同義）。
            "D " ) ((staged++)) ;; # ステージング済みの削除がある。
            "D." ) ((staged++)) ;; # ステージング済みの削除がある（D  と同義）。
            "DD" ) ((unmerged++));((conflict++)) ;; # マージ競合（両方で削除された）。
            "UU" ) ((unmerged++)); ((conflict++)) ;; # マージ競合（両方で変更された）。
            "AU" ) ((unmerged++)); ((conflict++)) ;; # マージ競合（追加と競合）。
            "UD" ) ((unmerged++)); ((conflict++)) ;; # マージ競合（更新と削除）。
            "DA" ) ((unmerged++)); ((conflict++)) ;; # マージ競合（削除と追加）。
          esac
          ;;
        "2 "*)
          local xy_for_2=${line:2:2}
          case "$xy_for_2" in
            "R " ) ((staged++)) ;; # ステージング済みの名前変更のみ。新しいファイルはワークツリーでさらに変更されていない。
            "R." ) ((staged++)) ;; # ステージング済みの名前変更のみ。新しいファイルはワークツリーでさらに変更されていない。
            "RM" ) ((staged++)); ((unstaged++)) ;; # ステージング済みの名前変更と、新しいファイルに対する未ステージングの変更がある。
            "RD" ) ((staged++)); ((unstaged++)) ;; # ステージング済みの名前変更と、新しいファイルに対するワークツリーでの削除がある。
            "C " ) ((staged++)) ;; # ステージング済みのコピーのみ。新しいファイルはワークツリーでさらに変更されていない。
            "C." ) ((staged++)) ;; # ステージング済みのコピーのみ。新しいファイルはワークツリーでさらに変更されていない。
            "CM" ) ((staged++)); ((unstaged++)) ;; # ステージング済みのコピーと、新しいファイルに対する未ステージングの変更がある。
            "CD" ) ((staged++)); ((unstaged++)) ;; # ステージング済みのコピーと、新しいファイルに対するワークツリーでの削除がある。
          esac
          ;;
        "?"*) ((untracked++)) ;;
      esac
    done <<< "$porcelain"

    local cfg_rows
    cfg_rows=$(while IFS= read -r line; do
      if [[ $line == "[remote "* ]]; then
        read -r next
        print -- "$line"$'\n'"$next"
        break
      fi
    done < $gitdir/config)

    local cfg_ar=(${(f)cfg_rows})
    local url=${cfg_ar[2]#*url = }
    local repo
    if [[ $url =~ "^git@" ]]; then
      repo="${url#*:*}"
    else
      repo="${url#https://*/}"
    fi

    local remote_tmp=${cfg_ar[1]#*\"}
    local remote=${remote_tmp%%\"*}
    local head=$(<$gitdir/HEAD)
    local branch="${head#ref: refs/heads/}"
    local merge
    [[ -f "$gitdir/MERGE_HEAD" ]] && merge="MERGE "
    local cherrypick
    [[ -f "$gitdir/CHERRY_PICK_HEAD" ]] && cherrypick="CHERRYPICK "
    local rebase
    [[ -f "$gitdir/REBASE_HEAD" ]] && rebase="REBASE "

    local workingtree="%F{1}untracked:${untracked} unstaged:${unstaged}%f"
    local unmerged_str
    local stash_str
    unmerged_str=$( [[ $unmerged -ge 1 ]] && print -n "UNMERGED:${unmerged} " )
    stash_str=$( [[ $stash -ge 1 ]] && print -n "STASH:${stash} " )
    local unmerged_stash_stage="%F{63}${unmerged_str}${stash_str}%f%F{168}staged:${staged}%f"
    local aheadbehind="%F{200}A${ahead} B${behind}%f"
    local git_caution="%K{1}${merge}${cherrypick}${rebase}%f%k"
    local repo_branch="%F{8}${repo} %F{8}${branch}%f %F{red}track(${remote:-none})%f "
    t2=${${EPOCHREALTIME/./}[1,13]}
    td1=$(( t1 - t0 ))
    td2=$(( t2 - t1 ))
    echo "[${workingtree}][${unmerged_stash_stage}][${aheadbehind}] ${git_caution}${repo_branch}(${td1}ms+${td2}ms)"
  fi
}
python_prompt() {
  local verf=$(find_up .python-version)
  if [[ -z "$verf" ]]; then
    return 0
  elif [[ -n "${VIRTUAL_ENV}" ]]; then
    printf "(python %s,%s)" "$(<$verf)" "${VIRTUAL_ENV/$HOME/\$HOME}"
  else
    printf "(python %s,%s)" "$(<$verf)" "${verf/$HOME/\$HOME}"
  fi
}
rbenv_prompt() {
  local verf=$(find_up .ruby-version)
  if [[ -z "$verf" ]]; then
    return 0
  else
    printf "(ruby %s,%s)" "$(<$verf)" "${verf/$HOME/\$HOME}"
  fi
}
basic_prompt() {
  local exit_cd="%F{red}%(?..\$?=%? )%f"
  local bg_job="%(1j|%F{5}bg:%j%f|)"
  local working_dir="%F{137}%~ %f"
  echo "${exit_cd}${bg_job}${working_dir}%F{245}%#%f "
}

precmd() {
  LLIST=()
  LLIST+=( "$(rbenv_prompt)" )
  LLIST+=( "$(python_prompt)" )
  LLIST+=( "$(git_prompt)" )
  LLIST+=( "$(basic_prompt)" )
  LLIST=(${LLIST[@]:#""(f)})
  PROMPT=$( print -n -- "\n${(j:\n:)LLIST[@]}")

  # RLIST=()
  # RLIST+=( "$(date +'%m/%d %H:%M:%S')" )
  # RLIST=(${RLIST[@]:#""(f)})
  # RPROMPT=$(print -n --   "${(j:| :)RLIST[@]}")
}
