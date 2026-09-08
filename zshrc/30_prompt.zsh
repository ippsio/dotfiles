autoload -Uz add-zsh-hook
# $1 を親ディレクトリ方向に探索し、見つかったパスを $REPLY に入れる(fork 無し)。
_find_up() {
  local dir=$PWD
  while [[ $dir != "/" ]]; do
    [[ -e $dir/$1 ]] && { REPLY=$dir/$1; return 0; }
    dir=${dir:h}
  done
  REPLY=
  return 1
}
find_up() { local REPLY; _find_up "$1" && echo $REPLY; }

# 各 *_prompt は結果を $REPLY に入れる(サブシェル $(...) を使わないため)。
git_prompt() {
  REPLY=
  _find_up .git || return 0
  local gitdir=$REPLY
  local t0 t1 t2 UNTRACKED UNSTAGED UNMERGED STASH STAGED AHEAD BEHIND BRANCH TRACK
  t0=${${EPOCHREALTIME/./}[1,13]}
  local untracked=0 unstaged=0 staged=0 unmerged=0 conflict=0 ahead=0 behind=0 stash=0
  local -a porcelain
  porcelain=("${(@f)$(git status --porcelain=v2 --branch --show-stash 2>/dev/null)}")
  t1=${${EPOCHREALTIME/./}[1,13]}
  local line
  for line in "${porcelain[@]}"; do
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
        case "${line:2:2}" in
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
        case "${line:2:2}" in
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
  done

  # .git/config の最初の "[remote ..." 行(とその次行)を取り出す。$(<file) は fork しない。
  local -a cfg_lines
  cfg_lines=("${(@f)$(<$gitdir/config)}")
  local i=${cfg_lines[(i)\[remote *]}
  # local url=${cfg_lines[i+1]#*url = }
  # local repo
  # if [[ $url =~ "^git@" ]]; then
  #   repo="${url#*:*}"
  # else
  #   repo="${url#https://*/}"
  # fi
  local remote_tmp=${cfg_lines[i]#*\"}
  local remote=${remote_tmp%%\"*}
  local head=$(<$gitdir/HEAD)
  local branch="${head#ref: refs/heads/}"
  local merge
  [[ -f "$gitdir/MERGE_HEAD" ]] && merge="MERGE "
  local cherrypick
  [[ -f "$gitdir/CHERRY_PICK_HEAD" ]] && cherrypick="CHERRYPICK "
  local rebase
  [[ -f "$gitdir/REBASE_HEAD" ]] && rebase="REBASE "

  local -a workingtree_ar
  UNTRACKED="%F{#AA6666}"
  UNSTAGED="%F{#AA6666}"
  [[ $untracked -ge 1 ]] && workingtree_ar+=( "${UNTRACKED}untracked:${untracked}%f" )
  [[ $unstaged -ge 1 ]] && workingtree_ar+=( "${UNSTAGED}unstaged:${unstaged}%f" )
  local workingtree="${(j: :)workingtree_ar[@]}"

  local -a uss_ar
  UNMERGED="%F{63}"
  STASH="%F{63}"
  STAGED="%F{168}"
  [[ $unmerged -ge 1 ]] && uss_ar+=( "${UNMERGED}UNMERGED:${unmerged}%f" )
  [[ $stash -ge 1 ]] && uss_ar+=( "${STASH}STASH:${stash}%f" )
  [[ $staged -ge 1 ]] && uss_ar+=( "${STAGED}staged:${staged}%f" )
  local unmerged_stash_stage="${(j: :)uss_ar[@]}"

  AHEAD="%F{#AA2299}"
  BEHIND="%F{#AA2299}"
  local aheadbehind="${AHEAD}A${ahead}%f ${BEHIND}B${behind}%f"

  local -a git_caution_ar
  [[ -n "$merge" ]] && git_caution_ar+=( "%K{1}${merge}%k")
  [[ -n "$cherrypick" ]] && git_caution_ar+=( "%K{1}${cherrypick}%k")
  [[ -n "$rebase" ]] && git_caution_ar+=( "%K{1}${rebase}%k")
  local git_caution="${(j: :)git_caution_ar[@]}"

  # REPO="%F{#999900}"
  BRANCH="%F{cyan}"
  TRACK="%F{#AA2299}"
  local -a repo_branch_ar
  # repo_branch_ar+=( "${REPO} \uF113 ${repo}" )
  repo_branch_ar+=( "${BRANCH} \uF126 ${branch}" )
  repo_branch_ar+=( "${TRACK}track(${remote:-none})%f" )
  local repo_branch
  print -v repo_branch -n -- "${(j: :)repo_branch_ar[@]}"   # \uF126 を print のエスケープ解釈で実文字に

  local out=
  [[ -n "$workingtree" ]] && out+="[${workingtree}]"
  [[ -n "$unmerged_stash_stage" ]] && out+="[${unmerged_stash_stage}]"
  [[ -n "$aheadbehind" ]] && out+="[${aheadbehind}]"
  [[ -n "$git_caution" ]] && out+=" ${git_caution}"
  [[ -n "$repo_branch" ]] && out+="${repo_branch}"
  t2=${${EPOCHREALTIME/./}[1,13]}
  # REPLY="${out}%F{8}($(( t1 - t0 ))ms+$(( t2 - t1 ))ms)%f"
  REPLY="${out}%F{8}%f"
}
python_prompt() {
  REPLY=
  _find_up .python-version || return 0
  local verf=$REPLY
  if [[ -n "${VIRTUAL_ENV}" ]]; then
    REPLY="%F{66}(python $(<$verf),${VIRTUAL_ENV/$HOME/\$HOME})%f"
  else
    REPLY="%F{66}(python $(<$verf),${verf/$HOME/\$HOME})%f"
  fi
}
rbenv_prompt() {
  REPLY=
  _find_up .ruby-version || return 0
  local verf=$REPLY
  # REPLY="%F{66}(ruby $(<$verf),${verf/$HOME/\$HOME})%f"
  REPLY="%F{66}(ruby $(<$verf))%f"
}
basic_prompt() {
  local exit_cd="%F{red}%(?..\$?=%? )%f"
  local bg_job="%(1j|%F{5}bg:%j%f|)"
  local working_dir="%F{137}%~ %f"
  REPLY="${exit_cd}${bg_job}${working_dir}%F{245}%#%f "
}

precmd() {
  local REPLY
  LLIST=()
  rbenv_prompt;  LLIST+=( "$REPLY" )
  python_prompt; LLIST+=( "$REPLY" )
  git_prompt;    LLIST+=( "$REPLY" )
  basic_prompt;  LLIST+=( "$REPLY" )
  LLIST=(${LLIST[@]:#""(f)})
  print -v PROMPT -n -- "\n${(j:\n:)LLIST[@]}"

  # RLIST=()
  # RLIST+=( "$(date +'%m/%d %H:%M:%S')" )
  # RLIST=(${RLIST[@]:#""(f)})
  # RPROMPT=$(print -n --   "${(j:| :)RLIST[@]}")
}
