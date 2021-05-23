# zsh起動時にtmux起動
if (type "tmux" > /dev/null 2>&1) ; then
  [[ -z "$TMUX" && ! -z "$PS1" ]] && tmux \
    && echo "$(date +'%Y/%m/%d %H:%M:%S')\nbyebye from tmux.\n(Closed after 1 sec.)" && sleep 2 && exit
   #&& echo "$(date +'%Y/%m/%d %H:%M:%S')\nbyebye from tmux.\n(Closed after 1 sec.)" && sleep 1
fi

# CTRL-D でログアウトしないようにする
setopt ignore_eof

# ------------------
# preparing section
# ------------------
# prepare essential utility/middle/environmental softwares.
source ~/dotfiles/prepare.zsh
### pyenv/rbenv/direnv/node
# 'pyenv init -' is no longer needed.
#eval "$(pyenv init -)"
eval "$(rbenv init -)"
eval "$(direnv hook zsh)"
eval "$(nodenv init -)"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# -------------------------------
# Authentic zsh settings section
# -------------------------------
source ~/dotfiles/zsh/00_alias.zsh
source ~/dotfiles/zsh/10_prompt.zsh
source ~/dotfiles/zsh/20_bindkeys.zsh
source ~/dotfiles/zsh/30_color_to_man.zsh
# custom functions
#for file in $(ls ~/dotfiles/zsh/custom_functions/*.zsh); { source $file }
# custom completion
# for file in $(ls ~/dotfiles/zsh/custom_completions/*.zsh); { source $file }

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000 # メモリに保存される履歴の件数
SAVEHIST=10000 # 履歴ファイルに保存される履歴の件数
setopt hist_ignore_dups # 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_all_dups # 重複するコマンドは古い法を削除する
setopt share_history # 異なるウィンドウでコマンドヒストリを共有する
setopt hist_no_store # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks # 余分な空白は詰めて記録
setopt hist_verify # `!!`を実行したときにいきなり実行せずコマンドを見せる

# ------------------
# zplug
# ------------------
source ${ZPLUG_HOME}/init.zsh
# zplug 'zsh-users/zsh-autosuggestions'
zplug "zsh-users/zsh-autosuggestions", hook-load: "ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(my_space_extraction my_tab_completion end-of-line $ZSH_AUTOSUGGEST_CLEAR_WIDGETS)"
zplug 'zsh-users/zsh-completions'
zplug "mollifier/anyframe"
zplug "zsh-users/zsh-history-substring-search", hook-build:"__zsh_version 4.3"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug "junegunn/fzf", use:shell/key-bindings.zsh
zplug "junegunn/fzf", use:shell/completion.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug check || zplug install
zplug load --verbose

