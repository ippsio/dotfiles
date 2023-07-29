#!/usr/bin/env zsh
# vi like
# bindkey -v

# emacs like
bindkey -e

# space
source ~/dotfiles/zshrc/41_zle_space.zsh
execute_zle_space() {
  [[ -z ${zle_space_timer} ]] && export zle_space_timer=$(epocms)
  zle_space && export zle_space_timer=$(epocms)
}

zle -N execute_zle_space
bindkey " " execute_zle_space

# ctrl-i(=tab)
if true; then
  source ~/dotfiles/zshrc/42_zle_tab.zsh
  zle -N triggered_by_tab
  bindkey "^I" triggered_by_tab
fi

# box_bracket_open() { [[ "${LBUFFER: -1}" != "\\" ]] && LBUFFER="${LBUFFER}\\[" || zle self-insert; }
# zle -N box_bracket_open
# bindkey "[" box_bracket_open
# box_bracket_close() { [[ "${LBUFFER: -1}" != "\\" ]] && LBUFFER="${LBUFFER}\\]" || zle self-insert; }
# zle -N box_bracket_close
# bindkey "]" box_bracket_close

# ctrl-d(=del)で前方削除
bindkey "^[[3~" delete-char

# ctrl-f
source ~/dotfiles/zshrc/43_zle_ctrl_f.zsh
zle -N zle_ctrl_f
bindkey "^F" zle_ctrl_f

# ctrl-g
source ~/dotfiles/zshrc/43_zle_ctrl_g.zsh
zle -N zle_ctrl_g
bindkey "^G" zle_ctrl_g

# zle_space関数終了後、300ミリ秒間はキー入力をスルーする。
# 早くキー操作しすぎた場合、コマンドプロンプトに期待しないキー入力が入る。
# この挙動を抑止する。
readonly KEY_INPUT_THROUGH_MILLIS=300
zle_through_or_self_insert() {
  diff=$(( $(epocms) - ${zle_space_timer:-0} ))
  if [[ ${diff} -gt $KEY_INPUT_THROUGH_MILLIS ]]; then
    # echo "IN    zle_space_timer=${zle_space_timer}, diff=${diff}" >> /tmp/key_through.log
    zle self-insert;
  else
    # echo "NOT-IN zle_space_timer=${zle_space_timer}, diff=${diff}" >> /tmp/key_through.log
  fi
}

# 以下の長いechoは、ほぼ printf "$(printf '\\x%x ' {33..127}) "の結果です。
# ダブルクォート、ハイフン、バッククォートはエスケープが必要だったっぽいので'\'でエスケープしてます。
zle -N zle_through_or_self_insert
for key in $(echo "' ! \" # $ % & ' ( ) * + , \- . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F G H I J K L M N O P Q R S T U V W X Y Z [ \ ] ^ _ \` a b c d e f g h i j k l m n o p q r s t u v w x y z { | } ~"); do
  bindkey "${key}" zle_through_or_self_insert
done

# Shift+<Left> で親階層のフォルダに移動
execute_zle_shift_left() { BUFFER="cd .." && zle accept-line; }
zle -N execute_zle_shift_left
bindkey "^[[1;2D" execute_zle_shift_left

