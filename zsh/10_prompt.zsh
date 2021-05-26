# vcs_info 設定
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz colors

zstyle ':vcs_info:*' max-exports 1
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '%m'
zstyle ':vcs_info:*' actionformats '%m'
zstyle ':vcs_info:git+set-message:*' hooks git-set-message-hook
function +vi-git-set-message-hook() {
  [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) != "true" ]] && return 1
  [[ "$1" != "0" ]] && return 0 # process when only for 1st messsge of zstyle formats, actionformats

  # obtain git command results
  local git_remote="$(git remote get-url origin 2> /dev/null)"
  local git_status="$(git status --porcelain --branch 2> /dev/null)"
  local git_stash="$(git stash list 2>/dev/null)"
  local git_log="$(git rev-list origin/${hook_com[branch]}..${hook_com[branch]} 2> /dev/null)"

  # collect results
  local repo=$(echo ${git_remote}| egrep -o "([a-zA-Z0-9+-]+)\/([a-zA-Z0-9+-]+).git$")
  local ahead=$(echo "${git_log}"| egrep -v "^$"       | wc -l| tr -d ' ')
  local behind=${$(echo ${git_status}   | egrep "^##"| egrep -o "behind [0-9]+"| sed -e "s/behind //"):-0}
  local untracked=$(echo "${git_status}"| egrep -c "^(\?\?)")
  local unstaged=$(echo "${git_status}" | egrep -c "^([ ADM]M)")
  local deleted=$(echo "${git_status}"  | egrep -c "^([ AM]D)")
  local staged=$(echo "${git_status}"   | egrep -c "^([AMD])")
  local stash=$(echo "${git_stash}" | sed '/^$/d'| wc -l| tr -d ' ')

  # misc (%m) に追加
  hook_com[misc]="${repo} ${hook_com[branch]} ${deleted} ${untracked} ${unstaged} ${staged} ${ahead} ${behind} ${stash} ${hook_com[action]}"
}

function _precmd_vcs_info_msg() {
  LANG=en_US.UTF-8 vcs_info
  psvar=();
  [[ -z ${vcs_info_msg_0_} ]] && return
  idx=1; for a_misc in `echo ${vcs_info_msg_0_}`; do; psvar[$idx]=${a_misc}; idx=`echo "$idx+1" | bc`; done
}

add-zsh-hook precmd _precmd_vcs_info_msg

# MARK DEFINITIONS
local _text_unstaged="wtree"
local _mark_deleted="x"
local _mark_untracked="?"
local _mark_unstaged="-"
local _text_staged="stage"
local _mark_staged="+"
local _text_repo="repo"
local _mark_ahead="^"
local _mark_behind="v"
local _mark_stash="stash"

# exit status and git basic infomations.
local EXIT_CD="%K{red}%(?.. [EXIT_CD=%?])%k"
local GIT_REPO_NAME="%K{24}%F{255}%(1v|[%1v|)%f%k"
local GIT_BRANCH="%K{24}%F{255}%(2v|(%2v)]|)%f%k"

# git working_tree
local _deleted="%(3v|${_text_unstaged}[${_mark_deleted}%3v|)"
local _untracked="%(4v| ${_mark_untracked}%4v|)"
local _unstaged="%(5v| ${_mark_unstaged}%5v]|)"
local GIT_WORKING_TREE="%K{94}%F{255}${_deleted}${_untracked}${_unstaged}%f%k"

# git stage
local _staged="%(6v| ${_text_staged}[${_mark_staged}%6v]|)%k"
local GIT_STAGE="%K{90}%F{255}${_staged}%f%k"

# git local repositry
local _ahead="%(7v| ${_text_repo}[${_mark_ahead}%7v|)"
local _behind="%(8v| ${_mark_behind}%8v]|)"
local GIT_LOCAL_REPO="%K{88}%F{255}${_ahead}${_behind}%f%k"

local _stash="%(9v| ${_mark_stash}(%9v) |)"
# 10v,11v,12v,13vって....。たぶんもっといいやり方あるんだろうけど、調べるのが面倒臭かったんです..
local _more_such_as_rebase="%(10v| %10v |)%(11v| %11v |)%(12v| %12v |)%(13v| %13v |)"
local GIT_CAUTION="%K{18}${_stash}${_more_such_as_rebase}%k"

# others
local CURRENT_DIRECTORY="%K{237}%F{255}[%~] %f%k"
local CURRENT_DATETIME="%K{237}%F{255}%D{%m/%d %T} %f%k"

local NUMBER_OF_JOBS="%(1j|%F{226}BackgroundJobs(%j)%f|)"

local LINE1="${EXIT_CD}${GIT_REPO_NAME}${GIT_BRANCH}${GIT_CAUTION}"
local LINE2="${GIT_WORKING_TREE}${GIT_STAGE}${GIT_LOCAL_REPO}${CURRENT_DIRECTORY}${CURRENT_DATETIME}"
local LINE3="${NUMBER_OF_JOBS}%K{238}%# %k"
local LINE_FEED="
"
PROMPT=""
[[ "${LINE1}" != "" ]] && PROMPT="${PROMPT}${LINE_FEED}${LINE1}"
[[ "${LINE2}" != "" ]] && PROMPT="${PROMPT}${LINE_FEED}${LINE2}"
[[ "${LINE3}" != "" ]] && PROMPT="${PROMPT}${LINE_FEED}${LINE3}"

#echo "${PROMPT}"
