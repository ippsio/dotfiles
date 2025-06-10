autoload -Uz add-zsh-hook
precmd() {
  PROMPT_ARRAY=()
  if git rev-parse --is-inside-work-tree>/dev/null 2>&1; then
    local git_status="$(git status --porcelain --branch --ahead-behind 2> /dev/null)"
    local xy=$(echo -e ${git_status}| sed -e "s/^\(..\).*$/\1/")

    local untracked=$(echo "${xy}"| grep -Ec "^(\?\?)")
    local unstaged=$(echo "${xy}"| grep -Ec "^([ MADRC][MDRC])")
    local unmerged=$(echo "${xy}"| grep -Ec "^([DAU][DAU])")
    local WORKTREE="%F{1}?${untracked} !${unstaged} x${unmerged}%f "

    local stash=$(git stash list 2>/dev/null| grep -Ec "^stash@")
    local STASH="%F{241}\$${stash}%f "

    local staged=$(echo "${xy}"| grep -Ec "^([MADRC][ MD])")
    local STAGE="%F{61}+${staged}%f "

    local ahead=$(echo -e ${git_status}| grep -E "ahead [0-9]*"| sed -e "s/^.*\[ahead \([0-9]*\).*/\1/")
    local behind=$(echo -e ${git_status}| grep -E "behind [0-9]*"| sed -e "s/^.*[ \[]behind \([0-9]*\).*/\1/")
    local AB="%F{200}A${ahead:-0} B${behind:-0}%f "

    local repo=$(git_reponame)
    local branch="$(git branch --show-current)"
    local remote=$(git config --local branch.${branch}.remote)
    local commit_msg=$(git log -1 --date=format:"%m/%d %H:%M" --pretty='%h %ad %an %s')
    local REPO_BRANCH="%F{8}${repo} %F{8}${branch}%f %F{red}track(${remote:-none}) %F{8}${commit_msg}%f"

    local merging=$(test -f "$(git rev-parse --git-dir)/MERGE_HEAD" && echo 'MERGING' || echo '')
    local GIT_CAUTION="%K{1}${merging}%f%k "

    PROMPT_ARRAY+=( "${WORKTREE}${STASH}${STAGE}${AB}${GIT_CAUTION}${REPO_BRANCH}" )
  fi

  if [[ -n "${VIRTUAL_ENV_PROMPT}" ]]; then
    local python_venv_name=$(basename "${VIRTUAL_ENV}")
    local python_version_name=$(pyenv version-name)
    PROMPT_ARRAY+=( "(python|${python_venv_name}|${python_version_name})" )
  fi

  local EXIT_CD="%F{red}%(?..\$?=%? )%f"
  local BG="%(1j|%F{5}bg:%j%f|)"
  local PWD="%F{137}%~ %f"
  PROMPT_ARRAY+=( "${EXIT_CD}${BG}${PWD}%F{245}#%f " )
  PROMPT=$(print -l "${PROMPT_ARRAY[@]}")
}
