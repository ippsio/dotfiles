#!/usr/bin/env zsh
# NOTE: エスケープシーケンスは cat -vで調べられるよ。

# emacs like
bindkey -e

# space
source ~/dotfiles/zshrc/41_zle_space.zsh
export zle_space_timer=0
execute_zle_space() { zle_space && zle_space_timer=$(epocms); return 0; }

zle -N execute_zle_space
bindkey " " execute_zle_space

# ctrl-i(=tab)
source ~/dotfiles/zshrc/42_zle_tab.zsh
# ctrl-d(=del)で前方削除
bindkey "^[[3~" delete-char
# ctrl-f
source ~/dotfiles/zshrc/43_zle_ctrl_f.zsh
# ctrl-g
source ~/dotfiles/zshrc/43_zle_ctrl_g.zsh

# zle_space関数終了後、一定時間(ms)はキーが入力を破棄する。
# 早くキー操作しすぎた場合、コマンドプロンプトに期待しないキー入力が入る。この入力を破棄する。
readonly KEY_INPUT_THROUGH_MILLIS=100
zle_through_or_self_insert() {
  difference=$(( t - zle_space_timer ))
  if [[ ${difference} -ge $KEY_INPUT_THROUGH_MILLIS ]]; then
    zle self-insert
    return 0
  elif [[ ${difference} -lt $(( 10 * 1000 )) ]]; then
    # 端末の時計を過去に戻ったりすると、キー入力が一切通らなくなることがあった。
    # 明らかすぎる時間のズレがあればこのブロックに到達し、キー入力が受け付けられるようにする。
    zle_space_timer=$t
    zle self-insert
    return 0
  fi
}
zle -N zle_through_or_self_insert
for key in $(echo $(printf '"\\x%x" ' {33..127})); do
  bindkey "\${key}" zle_through_or_self_insert
done

# Shift+<Left> で親階層のフォルダに移動
execute_zle_shift_left() { BUFFER="cd .." && zle accept-line; }
zle -N execute_zle_shift_left
bindkey "^[[1;2D" execute_zle_shift_left

source ~/dotfiles/zshrc/44_zle_enter.zsh

# f1で ~/dotfiles/bin配下に存在するコマンドの候補をFZFで選択するインタフェースを提供する。
zle_f1() {
  BUFFER=$( (rg --follow --files ~/dotfiles/bin\
    | awk '{ ABSOLUTE=$0; gsub(/^.*\//, "", $1); BASENAME=$0; print BASENAME"\t("ABSOLUTE")" }'| column -t\
    | (fzf --query "^${BUFFER}" --nth 1 || printf "%s" "${BUFFER}")\
    | awk '{ printf $1 }' )
  )
  zle end-of-line
  return 0
}
zle -N zle_f1
bindkey "^[OP" zle_f1

