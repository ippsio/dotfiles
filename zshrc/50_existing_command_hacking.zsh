# manコマンドの結果をneovimで開く
# not sure why but the -M flag breaks it but it's not required
# Seems like nvim already sets -M when ft=man
man() { /usr/bin/man $* -P 'col -b | nvim -R -c "set ft=man ts=8 nomod nolist nospell nu" -c "nun <buffer> q" -c "nn q :qa!<CR>" -' };
