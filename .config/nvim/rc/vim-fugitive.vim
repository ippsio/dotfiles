if !jetpack#tap(expand('<script>:t:r'))
  finish " このファイル名に該当するプラグインがJetpack上で有効でない場合finishします
endif

nnoremap <silent> <space>a :Git blame<CR>
augroup FugitiveAutocmd
  autocmd!
  " fugitive の blame だけになった時、quitする。
  autocmd WinEnter * if winnr('$') == 1 && expand('%p') =~ '.fugitiveblame' | quit | endif
augroup END

