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
    local untracked=0 unstaged=0 staged=0 unmerged=0 ahead=0 behind=0 stash=0
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
          local xy=${line:2:2}
          case "$xy" in
            "?M"|" M"|".M") ((unstaged++)) ;;
            "M"?) ((staged++)) ;;
            "A"?) ((staged++)) ;;
          esac
          ;;
        "2 "*) ((unmerged++)) ;;
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
    local repo=${cfg_ar[2]#*url = }
    local remote_tmp=${cfg_ar[1]#*\"}
    local remote=${remote_tmp%%\"*}
    local head=$(<$gitdir/HEAD)
    local branch="${head#ref: refs/heads/}"
    local merging
    [[ -f "$gitdir/MERGE_HEAD" ]] && merging="MERGING"
    local cherrypicking
    [[ -f "$gitdir/CHERRY_PICK_HEAD" ]] && cherrypicking="CHERRYPICKING"

    local workingtree="%F{1}?${untracked} !${unstaged}%f"
    local unmerged_str
    local stash_str
    unmerged_str=$( [[ $unmerged -ge 1 ]] && print -n "UNMERGED:${unmerged} " )
    stash_str=$( [[ $stash -ge 1 ]] && print -n "STASH:${stash} " )
    local unmerged_stash_stage="%F{63}${unmerged_str}${stash_str}%f%F{168}+${staged}%f"
    local aheadbehind="%F{200}A${ahead} B${behind}%f"
    local git_caution="%K{1}${merging}${cherrypicking}%f%k "
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

  RLIST=()
  RLIST+=( "$(date +'%m/%d %H:%M:%S')" )
  RLIST=(${RLIST[@]:#""(f)})

  PROMPT=$( print -n -- "\n${(j:\n:)LLIST[@]}")
  RPROMPT=$(print -n --   "${(j:| :)RLIST[@]}")
}
