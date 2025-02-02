#!/usr/bin/env zsh
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
    # 時計ずらしたときとか
    zle_space_timer=$t
    zle self-insert
    return 0
  fi
}

zle -N zle_through_or_self_insert
# keysの結果＝printf "$(printf '\\x%x ' {33..127}) "
keys="!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_\`abcdefghijklmnopqrstuvwxyz{|}~"
for ((i=0; i<${#keys}; i++)); do
  # ハイフンはエスケープが必要
  # bindkey "-" zle_through_or_self_insert #=> zle "zle_through_or_self_insert" undefined-key
  # bindkey "\-" zle_through_or_self_insert #=> OK
  __key="${keys:${i}:1}"
  bindkey "${__key/-/\-}" zle_through_or_self_insert
done

# Shift+<Left> で親階層のフォルダに移動
execute_zle_shift_left() { BUFFER="cd .." && zle accept-line; }
zle -N execute_zle_shift_left
bindkey "^[[1;2D" execute_zle_shift_left

source ~/dotfiles/zshrc/44_zle_enter.zsh

