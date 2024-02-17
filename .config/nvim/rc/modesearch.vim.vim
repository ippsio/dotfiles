if !jetpack#tap(expand('<script>:t:r'))
  finish " このファイル名に該当するプラグインがJetpack上で有効でない場合finishします
endif

cmap <C-x> <Plug>(modesearch-toggle-mode)

" Always starts in 'rawstr' mode
nmap ? <Plug>(modesearch-slash-rawstr)

