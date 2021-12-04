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
  local git_status="$(git status --porcelain --branch --ahead-behind 2> /dev/null)"
  local git_XY="$(echo -e ${git_status}| sed -e "s/^\(..\).*$/\1/")"

  local stash="$(git stash list 2>/dev/null| egrep "^stash@"| wc -l| tr -d ' ')"
  [[ "${stash}" == "0" ]] && stash=""

  # collect results
  local repo=$(echo ${git_remote}| egrep -o "([a-zA-Z0-9_+-]+)\/([a-zA-Z0-9_+-]+)(.git)?$")
  [ -z ${repo} ] && repo="NOT_SPECIFIED"
  local ahead=$(echo -e ${git_status}| egrep "ahead [0-9]*"| sed -e "s/^.*\[ahead \([0-9]*\).*/\1/")
  [ -z ${ahead} ] && ahead=0

  # case
  # ## master...origin/master [ahead 1]
  # ## master...origin/master [behind 1]
  # ## master...origin/master [ahead 1, behind 1]
  local behind=$(echo -e ${git_status}| egrep "behind [0-9]*"| sed -e "s/^.*[ \[]behind \([0-9]*\).*/\1/")
  [ -z ${behind} ] && behind=0

  # <indexに載ってるもの>
  # local updated_in_index=$(             echo "${git_XY}"| egrep -c "^(M[ MD])")
  # local added_to_index=$(               echo "${git_XY}"| egrep -c "^(A[ MD])")
  # local deleted_from_index=$(           echo "${git_XY}"| egrep -c "^(D[ ])")
  # local renamed_in_index=$(             echo "${git_XY}"| egrep -c "^(R[ MD])")
  # local copied_in_index=$(              echo "${git_XY}"| egrep -c "^(C[ MD])")
  # local not_updated=$(                  echo "${git_XY}"| egrep -c "^([AMD][ ])")
  # local index_and_work_tree_matches=$(  echo "${git_XY}"| egrep -c "^([MARC][ ])")

  # 上記を参考にすると、これからgit commitしないといかんものはつまり、これだ
  local index=$(echo "${git_XY}"| egrep -c "^([MADRC][ MD])")
  # </indexに載ってるもの>

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
  local unstaged=$(                     echo "${git_XY}"| egrep -c "^([ MADRC][MADRCU])")
  # local deleted=$(                      echo "${git_XY}"| egrep -c "^([ MADRC][D])")
  # </worktreeの変更>

  local untracked=$(                    echo "${git_XY}"| egrep -c "^(\?\?)")
  # local ignored=$(                      echo "${git_XY}"| egrep -c "^(!!)")

  # local stash=$(echo "${git_XY}" | sed '/^$/d'| wc -l| tr -d ' ')

# ---------------------------
# FYI: from `man git-status`
# ---------------------------
#
#   Short Format
#       In the short-format, the status of each path is shown as one of these forms
#
#       XY PATH
#       XY ORIG_PATH -> PATH
#
#       where ORIG_PATH is where the renamed/copied contents came from. ORIG_PATH is only shown when the
#       entry is renamed or copied. The XY is a two-letter status code.
#
#       The fields (including the ->) are separated from each other by a single space. If a filename
#       contains whitespace or other nonprintable characters, that field will be quoted in the manner of a
#       C string literal: surrounded by ASCII double quote (34) characters, and with interior special
#       characters backslash-escaped.
#
#       There are three different types of states that are shown using this format, and each one uses the
#       XY syntax differently:
#
#       o   When a merge is occurring and the merge was successful, or outside of a merge situation, X
#       shows the status of the index and Y shows the status of the working tree.
#
#       o   When a merge conflict has occurred and has not yet been resolved, X and Y show the state
#       introduced by each head of the merge, relative to the common ancestor. These paths are said to
#       be unmerged.
#
#       o   When a path is untracked, X and Y are always the same, since they are unknown to the index.
#       ??  is used for untracked paths. Ignored files are not listed unless --ignored is used; if it
#       is, ignored files are indicated by !!.
#
#       Note that the term merge here also includes rebases using the default --merge strategy,
#       cherry-picks, and anything else using the merge machinery.
#
#       In the following table, these three classes are shown in separate sections, and these characters
#       are used for X and Y fields for the first two sections that show tracked paths:
#   o   ' ' = unmodified
#   o   M = modified
#   o   A = added
#   o   D = deleted
#   o   R = renamed
#   o   C = copied
#   o   U = updated but unmerged
#       X        Y     Meaning(X=the status of the index, Y=the status of the working tree)
#       -------------------------------------------------
#              [AMD]   not updated
#       M      [ MD]   updated in index
#       A      [ MD]   added to index
#       D              deleted from index
#       R      [ MD]   renamed in index
#       C      [ MD]   copied in index
#       [MARC]         index and work tree matches
#       [ MARC]   M    work tree changed since index
#       [ MARC]   D    deleted in work tree
#       [ D]      R    renamed in work tree
#       [ D]      C    copied in work tree
#       -------------------------------------------------
#       D            D    unmerged, both deleted
#       A            U    unmerged, added by us
#       U            D    unmerged, deleted by them
#       U            A    unmerged, added by them
#       D            U    unmerged, deleted by us
#       A            A    unmerged, both added
#       U            U    unmerged, both modified
#       -------------------------------------------------
#       ?            ?    untracked
#       !            !    ignored
#       -------------------------------------------------


  # misc (%m) に追加
  hook_com[misc]="${repo} ${hook_com[branch]} ${untracked} ${unstaged} ${index} ${ahead} ${behind} ${stash} ${hook_com[action]}"
}

function _precmd_vcs_info_msg() {
  LANG=en_US.UTF-8 vcs_info
  psvar=();
  [[ -z ${vcs_info_msg_0_} ]] && return
  idx=1; for a_misc in `echo ${vcs_info_msg_0_}`; do; psvar[$idx]=${a_misc}; idx=`echo "$idx+1" | bc`; done
}

add-zsh-hook precmd _precmd_vcs_info_msg

# MARK DEFINITIONS
# _text_worktree="wtree"
_text_worktree="worktree"
#_mark_deleted="x"
_mark_untracked="?"
_mark_unstaged="m"
# _text_staged="stage"
_text_staged="index"
_mark_staged="+"
# _text_repo="repo"
_text_repo="repo"
## # そういう文字が使えるフォント環境の場合
## _mark_ahead="$(echo '\u2191')"  # ↑
## _mark_behind="$(echo '\u2193')" # ↓
## _mark_stash="stash"
## _mark_branch="" # VCS_BRANCH_ICON                $'\uF126 '             # 
## _mark_git_repo="" # VCS_GIT_GITHUB_ICON            $'\uF113 '             # 

# じゃない場合
_mark_ahead="^"
_mark_behind="v"
_mark_stash="stash"
_mark_branch=""
_mark_git_repo=""

# exit status and git basic infomations.
EXIT_CD="%K{red}%(?.. [\$?=%?])%k"
GIT_REPO_NAME="%K{118}%F{0}%(1v|[${_mark_git_repo}%1v|)%f%k"
# '\ue0a0' is a git branch mark(icon).
GIT_BRANCH="%K{220}%F{0}%(2v| ${_mark_branch}%2v]|)%f%k"

# git working_tree
#_deleted="%(3v|${_text_worktree}[${_mark_deleted}%3v|)"
_untracked="%(3v| ${_text_worktree}[${_mark_untracked}%3v|)"
_unstaged="%(4v| ${_mark_unstaged}%4v]|)"
GIT_WORKING_TREE="%K{8}%F{143}${_untracked}${_unstaged}%f%k"

# git stage
_staged="%(5v| ${_text_staged}[${_mark_staged}%5v]|)%k"
# GIT_STAGE="%K{90}%F{255}${_staged}%f%k"
GIT_STAGE="%K{61}%F{153}${_staged}%f%k"

# git local repositry
_ahead="%(6v| ${_text_repo}[${_mark_ahead}%6v|)"
_behind="%(7v| ${_mark_behind}%7v]|)"
GIT_LOCAL_REPO="%K{90}%F{200}${_ahead}${_behind}%f%k"

_stash="%(8v| ${_mark_stash}(%8v) |)"
# 10v,11v,12v,13vって....。たぶんもっといいやり方あるんだろうけど、調べるのが面倒臭かったんです..
_more_such_as_rebase="%(10v| %10v |)%(11v| %11v |)%(12v| %12v |)%(13v| %13v |)"
GIT_CAUTION="%K{18}${_stash}${_more_such_as_rebase}%k"

# others
CURRENT_DIRECTORY="%K{237}%F{255}[%~] %f%k"
CURRENT_DATETIME="%K{237}%F{255}%D{%m/%d %T} %f%k"

NUMBER_OF_JOBS="%(1j|%F{226}BackgroundJobs(%j)%f|)"

LINE1="${EXIT_CD}${GIT_REPO_NAME}${GIT_BRANCH}"
LINE2="${GIT_WORKING_TREE}${GIT_STAGE}${GIT_LOCAL_REPO}"
LINE3="${NUMBER_OF_JOBS}${CURRENT_DIRECTORY}%K{238}%# %k"
LINE_FEED="
"
PROMPT=""
[[ "${LINE1}" != "" ]] && PROMPT+="${LINE_FEED}${LINE1}"
[[ "${LINE2}" != "" ]] && PROMPT+=" ${LINE2}"
[[ "${LINE3}" != "" ]] && PROMPT+="${LINE_FEED}${LINE3}"

RPROMPT="${GIT_CAUTION}${CURRENT_DATETIME}"
#echo "${PROMPT}"
