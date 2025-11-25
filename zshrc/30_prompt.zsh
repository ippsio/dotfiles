autoload -Uz add-zsh-hook
is_inside_work_tree() {
  if git rev-parse --is-inside-work-tree>/dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}
any_commits() {
  if git log>/dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}
find_up() {
  local name="$1"
  local dir=$PWD
  while [[ $dir != "/" ]]; do
    if [[ -e $dir/$name ]]; then
      echo "$dir/$name"
      return 0
    fi
    dir=${dir:h}
  done
  return 1
}

precmd() {
  PROMPT_ARRAY=()
  if is_inside_work_tree && any_commits; then
    t0=$($HOME/dotfiles/bin/epocms/epocms_c)
    if false; then
      local git_status="$(git status --porcelain --branch --ahead-behind 2>/dev/null)"
      local xy=$(echo -e ${git_status}| sed -e "s/^\(..\).*$/\1/")

      local untracked=$(echo "${xy}"| grep -Ec "^(\?\?)")
      local unstaged=$(echo "${xy}"| grep -Ec "^([ MADRC][MDRC])")
      local unmerged=$(echo "${xy}"| grep -Ec "^([DAU][DAU])")
      local stash=$(git stash list 2>/dev/null| grep -Ec "^stash@")
      local staged=$(echo "${xy}"| grep -Ec "^([MADRC][ MD])")
      local ahead=$( echo -e ${git_status}| grep -E "ahead [0-9]*"| sed -e "s/^.*\[ahead \([0-9]*\).*/\1/")
      local behind=$(echo -e ${git_status}| grep -E "behind [0-9]*"| sed -e "s/^.*[ \[]behind \([0-9]*\).*/\1/")
      ahead="${ahead:-0}"
      behind="${behind:-0}"
    elif false; then
      local untracked=$(git ls-files --others --exclude-standard | wc -l| tr -d ' ')
      local unstaged=$(git diff --name-only | wc -l| tr -d ' ')
      local unmerged=$(git ls-files --unmerged | wc -l| tr -d ' ')
      local stash=$(git stash list 2>/dev/null| grep -Ec "^stash@")
      local staged=$(git diff --cached --name-only | wc -l| tr -d ' ')
      read behind ahead < <(git rev-list --left-right --count @{upstream}...HEAD 2>/dev/null)

      # stash だけは別（ただし Git 非起動で読む方法あり）
      stash=$(git stash list 2>/dev/null | grep -c '^stash@')
    else

      local porcelain
      porcelain=$(git status --porcelain=v2 -b 2>/dev/null) || return 1

      # counters
      local untracked=0 unstaged=0 staged=0 unmerged=0 ahead=0 behind=0 stash=0

      local line
      while IFS= read -r line; do
        case "$line" in
          \#\ branch.ab*)
            # +ahead -behind にマッチ
            ahead=${line#*+}
            ahead=${ahead%% *}
            behind=${line#*-}
            behind=${behind%% *}
            ;;
          "1 "*)
            # 1 <xy> <path>
            local xy=${line:2:2}
            case "$xy" in
              "?M"|" M"| ".M") ((unstaged++)) ;;
              "M"?) ((staged++)) ;;
            esac
            ;;
          "2 "*) ((unmerged++)) ;;
          "?"*) ((untracked++)) ;;
        esac
      done <<< "$porcelain"
    fi

    local _git="$(find_up .git)"
    local remote01=$(cat "$_git/config"| grep -FA1 '[remote ')
    local repo=$(echo "$remote01"| tail -n 1|awk -F':' '{ print $2 }'| sed 's/\.git$//')
    local remote=$(echo "$remote01"| head -1| grep -Eo '("[a-z]+")'| sed 's/"//g')
    local head=$(cat "$_git/HEAD")
    local branch="${head#ref: refs/heads/}"
    # NOTE: 重いのでコメントアウト
    # local merging=$(test -f "$(git rev-parse --git-dir)/MERGE_HEAD" && echo 'MERGING' || echo '')
    # NOTE: 重いのでコメントアウト

    t1=$($HOME/dotfiles/bin/epocms/epocms_c)
    local WORKTREE="%F{1}?${untracked} !${unstaged} x${unmerged}%f"
    local STASH="%F{241}\$${stash}%f "
    local STAGE="%F{61}+${staged}%f"
    local AB="%F{200}A${ahead} B${behind}%f"
    local REPO_BRANCH="%F{8}${repo} %F{8}${branch}%f %F{red}track(${remote:-none}) %F{250}${commit_msg}%f"
    local GIT_CAUTION="%K{1}${merging}%f%k "

    local git_part=""
    git_part+="[${WORKTREE}]"
    git_part+="[${STASH} ${STAGE}]"
    git_part+="[${AB}]"
    git_part+="${GIT_CAUTION}"
    git_part+="${REPO_BRANCH}"
    PROMPT_ARRAY="${git_part}"
  fi

  if [[ -n "${VIRTUAL_ENV_PROMPT}" ]]; then
    local python_venv_name=$(basename "${VIRTUAL_ENV}")
    local python_version_name=$(pyenv version-name)
    PROMPT_ARRAY+=( "(python|${python_venv_name}|${python_version_name})" )
  fi

  local EXIT_CD="%F{red}%(?..\$?=%? )%f"
  local BG="%(1j|%F{5}bg:%j%f|)"
  local PWD="%F{137}%~ %f"
  PROMPT_ARRAY+=( "${EXIT_CD}${BG}${PWD}%F{245}%#%f " )
  td=$(( t1 - t0 ))
  PROMPT=$(print -l "\n${PROMPT_ARRAY[@]}")
  RPROMPT=$(date +'%m/%d %H:%M:%S')
}
