# vcs_info 設定
autoload -Uz vcs_info

# hook関数の登録。 ex) add-zsh-hook <hook名> <関数名>
autoload -Uz add-zsh-hook

# zshでプロンプトをカラー表示する。
# autoload -Uz colors

zstyle ':vcs_info:*' max-exports 1
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '%m'
zstyle ':vcs_info:*' actionformats '%m'
zstyle ':vcs_info:git+set-message:*' hooks git-set-message-hook

# ${git_status}がとり得るケース
# ## master...origin/master [ahead 1]
# ## master...origin/master [behind 1]
# ## master...origin/master [ahead 1, behind 1]
#
# # なぜgit status とgit rev-list のahead/ behind に差が出るのか、俺はその理由を知らない..
# # ただし差が出る事がある。差が出る時はだいたいstatusのaheadとbehindが0。そういうケースを疑ってrev-listする。
# if [[ ${ahead_7} -eq 0 && ${behind_8} -eq 0 ]]; then
#    if [[ git branch -a --format="%(refname:short)"|grep "^$origin/${hook_com[branch]}$" > /dev/null 2>&1 ]]; then
#     local revlist=$(git rev-list --left-right --count origin/${hook_com[branch]}...${hook_com[branch]})
#     ahead_7=$(echo "${revlist}"| awk '{ print $2 }')
#     behind_8=$(echo "${revlist}"| awk '{ print $1 }')
#    else
#      ahead_7="9999"
#    fi
# fi

# <indexに載ってるもの>
# local updated_in_index=$(             echo "${git_XY}"| egrep -c "^(M[ MD])")
# local added_to_index=$(               echo "${git_XY}"| egrep -c "^(A[ MD])")
# local deleted_from_index=$(           echo "${git_XY}"| egrep -c "^(D[ ])")
# local renamed_in_index=$(             echo "${git_XY}"| egrep -c "^(R[ MD])")
# local copied_in_index=$(              echo "${git_XY}"| egrep -c "^(C[ MD])")
# local not_updated=$(                  echo "${git_XY}"| egrep -c "^([AMD][ ])")
# local index_and_work_tree_matches=$(  echo "${git_XY}"| egrep -c "^([MARC][ ])")
# 上記を参考にすると、これからgit commitしないといかんものはつまり、これだ
# local index_6=$(echo "${git_XY}"| egrep -c "^([MADRC][ MD])")
# # </indexに載ってるもの>
#
#
# <worktreeの変更>
# local work_tree_changed_since_index=$(echo "${git_XY}"| egrep -c "^([ MARC]M)")
# local deleted_in_work_tree=$(         echo "${git_XY}"| egrep -c "^([ MARC]D)")
# local renamed_in_work_tree=$(         echo "${git_XY}"| egrep -c "^([ D]R)")
# local copied_in_work_tree=$(          echo "${git_XY}"| egrep -c "^([ D]C)")

# local unmerged_both_deleted=$(        echo "${git_XY}"| egrep -c "^(DD)")
# local unmerged_added_by_us=$(         echo "${git_XY}"| egrep -c "^(AU)")
# local unmerged_deleted_by_them=$(     echo "${git_XY}"| egrep -c "^(UD)")
# local unmerged_added_by_them=$(       echo "${git_XY}"| egrep -c "^(UA)")
# local unmerged_deleted_by_us=$(       echo "${git_XY}"| egrep -c "^(DU)")
# local unmerged_both_added=$(          echo "${git_XY}"| egrep -c "^(AA)")
# local unmerged_both_modified=$(       echo "${git_XY}"| egrep -c "^(UU)")

# 上記を参考にすると、これからgit addしないといかんものはつまり、これだ
# local unstaged_4=$(                     echo "${git_XY}"| egrep -c "^([ MADRC][MDRC])")
# 上記を参考にすると、merge時の競合を解決しないといけないものはたぶんこれ。
# local unmerged_5=$(                     echo "${git_XY}"| egrep -c "^([DAU][DAU])")
# </worktreeの変更>
+vi-git-set-message-hook() {
  [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) != "true" ]] && return 1
  [[ "$1" != "0" ]] && return 0 # process when only for 1st messsge of zstyle formats, actionformats

  # obtain git command results
  local git_status="$(git status --porcelain --branch --ahead-behind 2> /dev/null)"
  local git_XY=$(echo -e ${git_status}| sed -e "s/^\(..\).*$/\1/")

  local repo_1=$(git_reponame)
  local untracked_3=$(echo "${git_XY}"| grep -Ec "^(\?\?)")
  local unstaged_4=$(echo "${git_XY}"| grep -Ec "^([ MADRC][MDRC])")
  local unmerged_5=$(echo "${git_XY}"| grep -Ec "^([DAU][DAU])")
  local index_6=$(echo "${git_XY}"| grep -Ec "^([MADRC][ MD])")
  local ahead_7=$(echo -e ${git_status}| egrep -E "ahead [0-9]*"| sed -e "s/^.*\[ahead \([0-9]*\).*/\1/")
  local behind_8=$(echo -e ${git_status}| grep -E "behind [0-9]*"| sed -e "s/^.*[ \[]behind \([0-9]*\).*/\1/")
  local stash_9="$(git stash list 2>/dev/null| grep -Ec "^stash@")"
  local has_remote_10=$(git config --local branch.${hook_com[branch]}.remote)
  local parent_branch=
  repo_1="${repo_1:-NOT_SPECIFIED}"
  ahead_7="${ahead_7:-0}"
  if [[ -z "${ahead_7}" ]]; then
    local parent_branch=$(git_obtain_parent_branch)
    if [[ -n "${parent_branch}" ]]; then
      aheading=$(git log --oneline "${parent_branch}"..HEAD| wc -l| tr -d ' ')
      ahead_7="${aheading}(${parent_branch}..HEAD)"
    fi
  fi
  behind_8="${behind_8:-0}"
  has_remote_10="track(${has_remote_10:-none})"

  # misc (%m) に追加
  hook_com[misc]="${repo_1}\t${hook_com[branch]}\t${untracked_3}\t${unstaged_4}\t${unmerged_5}\t${index_6}\t${ahead_7}\t${behind_8}\t${stash_9}\t${has_remote_10}\t${hook_com[action]}"
}

my_precmd_hook() { return 0; }
my_chpwd_hook() { return 0; }
my_periodic_hook() { return 0; }
my_preexec_hook() { return 0; }
my_zshaddhistory_hook() { return 0; }

readonly REGEX_BINDING_PART="%K{[0-9]+}(vi-VISUAL|vi-NORMAL|vi-INSERT) %#"
update_binding_part() {
  if [[ $REGION_ACTIVE -ne 0 ]]; then
    PROMPT=$(echo -e "$PROMPT"| sed -E "s/${REGEX_BINDING_PART}/%K{34}vi-VISUAL %#/")
    zle reset-prompt
  elif [[ $KEYMAP = vicmd ]]; then
    PROMPT=$(echo -e "$PROMPT"| sed -E "s/${REGEX_BINDING_PART}/%K{54}vi-NORMAL %#/")
    zle reset-prompt
  elif [[ $KEYMAP = main ]]; then
    PROMPT=$(echo -e "$PROMPT"| sed -E "s/${REGEX_BINDING_PART}/%K{17}vi-INSERT %#/")
    zle reset-prompt
  fi
  return 0
}

zle-line-init() { update_binding_part; return 0; }
zle-line-pre-redraw() { update_binding_part; return 0; }
zle-keymap-select() { update_binding_part; return 0; }

precmd() {
  LANG=en_US.UTF-8 vcs_info
  psvar=( $(echo "${vcs_info_msg_0_}") )

  SEPARATOR_OPEN=" "
  SEPARATOR_CLOSE=" "

  # git basic infomations.
  _mark_git_repo=""
  _mark_branch=""
  GIT_REPO_BRANCH="%K{118}%F{0}"
  GIT_REPO_BRANCH+="%(1v|${SEPARATOR_OPEN}${_mark_git_repo}%1v|)"
  GIT_REPO_BRANCH+="%f%k"
  GIT_REPO_BRANCH+="%K{220}%F{0}"
  GIT_REPO_BRANCH+="%(2v| ${_mark_branch}%2v${SEPARATOR_CLOSE}|)"
  GIT_REPO_BRANCH+="%f%k"

  # git working_tree
  _mark_untracked="unt"
  _mark_unstaged="uns"
  _mark_unmerged="unm"
  GIT_WORKING_TREE="%K{193}%F{241}"
  GIT_WORKING_TREE+="%(3v|${SEPARATOR_OPEN}${_mark_untracked}%3v|)"
  GIT_WORKING_TREE+="%(4v| ${_mark_unstaged}%4v|)"
  GIT_WORKING_TREE+="%(5v| ${_mark_unmerged}%5v${SEPARATOR_CLOSE}|)"
  GIT_WORKING_TREE+="%f%k"

  _mark_stash="sta"
  GIT_STASH="%K{193}%F{241}"
  GIT_STASH+="%(9v|${_mark_stash}%9v${SEPARATOR_CLOSE}|%v)"
  GIT_STASH+="%f%k"

  # git stage
  _mark_staged="stg"
  GIT_STAGE="%K{61}%F{153}"
  GIT_STAGE+="%(6v|${SEPARATOR_OPEN}${_mark_staged}%6v${SEPARATOR_CLOSE}|)%k"
  GIT_STAGE+="%f%k"

  # git local repositry
  _mark_ahead="ahe"
  _mark_behind="beh"
  GIT_LOCAL_REPO="%K{90}%F{200}"
  GIT_LOCAL_REPO+="%(7v|${SEPARATOR_OPEN}${_mark_ahead}%7v|)"
  GIT_LOCAL_REPO+="%(8v| ${_mark_behind}%8v${SEPARATOR_CLOSE}|)"
  GIT_LOCAL_REPO+="%f%k"

  # 10v,11v,12v,13vって....。たぶんもっといいやり方あるんだろうけど、調べるのが面倒臭かったんです..
  GIT_CAUTION="%K{1}"
  GIT_CAUTION+="%(10v| %10v |)"
  GIT_CAUTION+="%(11v| %11v |)"
  GIT_CAUTION+="%(12v| %12v |)"
  GIT_CAUTION+="%(13v| %13v |)"
  GIT_CAUTION+="%k"

  # others
  EXIT_CD="%K{red}%(?..${SEPARATOR_OPEN}\$?=%?${SEPARATOR_CLOSE})%k"
  NUMBER_OF_JOBS="%F{226}bg(%j)"
  CURRENT_DIRECTORY="%K{237}%F{255}${SEPARATOR_OPEN}%~${SEPARATOR_CLOSE} %f%k"

  CHUNK1="${GIT_WORKING_TREE}${GIT_STASH}${GIT_STAGE}${GIT_LOCAL_REPO}"
  CHUNK2="${GIT_REPO_BRANCH}"
  CHUNK3="${EXIT_CD}${NUMBER_OF_JOBS}${CURRENT_DIRECTORY}${GIT_CAUTION}%K{238}%k"
  CHUNK4="$(precmd_python_venv)%# "
  # viモードの場合、これを指定しても良い。
  #CHUNK4="%K{25}vi-INSERT %# "

  PROMPT=$'\n'
  [[ ! -z "${CHUNK1}" ]] && PROMPT+="${CHUNK1}"
  [[ ! -z "${CHUNK2}" ]] && PROMPT+="${CHUNK2}"
  [[ ! -z "${CHUNK3}" ]] && PROMPT+=$'\n'"${CHUNK3}"
  [[ ! -z "${CHUNK4}" ]] && PROMPT+=$'\n'"${CHUNK4}"
}

precmd_python_venv() {
  if [[ ! -z "${VIRTUAL_ENV_PROMPT}" ]]; then
    python_venv_name=$(basename "${VIRTUAL_ENV}")
    python_version_name=$(pyenv version-name)
    printf "(python|%s|%s) " "${python_venv_name}" "${python_version_name}"
  fi
  return 0
}

## 以前のプロンプトにはコマンドラインを確定した時刻を表示
my-accept-line() {
  PROMPT=$(echo -e "$PROMPT"| sed -E "s/${REGEX_BINDING_PART}/%#/")
  zle .reset-prompt
  zle .accept-line
}

# zshのフック登録
add-zsh-hook precmd my_precmd_hook
add-zsh-hook chpwd my_chpwd_hook
add-zsh-hook periodic my_periodic_hook
add-zsh-hook preexec my_preexec_hook
add-zsh-hook zshaddhistory my_zshaddhistory_hook

# viモードの場合、これを使っても良い。
# zle -N zle-line-init
# zle -N zle-keymap-select
# zle -N zle-line-pre-redraw

zle -N accept-line my-accept-line

