#!/bin/sh
### export FZF_DEFAULT_OPTS="\
###   -e \
###   --extended \
###   --reverse \
###   --border \
###   --bind 'ctrl-v:execute(vim {})' \
###   --preview-window=bottom:60%:wrap
###   "
###   # --bind change:top \

export FZF_DEFAULT_OPTS="\
  --exact \
  --extended \
  --reverse \
  --border \
  --bind 'F11:down' \
  --bind 'F12:up' \
  --bind 'ctrl-v:execute(vim {})' \
  --bind change:top \
  --preview-window=bottom:60%:wrap"

### export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
### --color fg:-1,bg:-1,hl:226,fg+:226,bg+:239,hl+:226
### --color info:108,prompt:48,spinner:108,pointer:168,marker:168'

# about color
#  hl         Highlighted substrings
#  fg+        Text (current line)
#  bg+        Background (current line)
#  gutter     Gutter on the left (defaults to bg+)
#  hl+        Highlighted substrings (current line)
#  query      Query string
#  disabled   Query string when search is disabled
#  info       Info line (match counters)
#  border     Border around the window (--border and --preview)
#  prompt     Prompt
#  pointer    Pointer to the current line
#  marker     Multi-select marker
#  spinner    Streaming input indicator
#  header     Header
#
#  -1	     Default terminal foreground/background color
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color fg:-1,bg:-1,hl:226
--color fg+:123,bg+:23,hl+:226
--color info:108,prompt:48,spinner:108,pointer:168,marker:168,header:201'

N="fzf"
if ! (type "fzf" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install fzf || return 1
fi
