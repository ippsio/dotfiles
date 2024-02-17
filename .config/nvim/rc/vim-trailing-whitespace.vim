if !jetpack#tap(expand('<script>:t:r'))
  finish " このファイル名に該当するプラグインがJetpack上で有効でない場合finishします
endif

" defxを開いた時にハイライトされるのを防ぐ。
let g:extra_whitespace_ignored_filetypes = ['defx']

