if !jetpack#tap(expand('<script>:t:r'))
  finish " このファイル名に該当するプラグインがJetpack上で有効でない場合finishします
endif

let g:loaded_matchparen = 1
hi ParenMatch ctermbg=27

