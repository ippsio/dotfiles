if !jetpack#tap(expand('<script>:t:r'))
  finish " このファイル名に該当するプラグインがJetpack上で有効でない場合finishします
endif

let g:cursorword_delay=50
let g:cursorword_highlight=0
hi CursorWord ctermbg=237 cterm=underline

