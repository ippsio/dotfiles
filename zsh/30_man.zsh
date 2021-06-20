# manコマンドの結果をneovimで開く
man() {
  /usr/bin/man $* -P "col -b | nvim -Rc 'setl ft=man ts=8 nomod nolist nonu' -c 'nmap q :q<cr>' -"
}
