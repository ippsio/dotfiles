if !jetpack#tap(expand('<script>:t:r'))
  finish " このファイル名に該当するプラグインがJetpack上で有効でない場合finishします
endif

autocmd FileType ruby,slim setlocal dictionary+=~/.cache/dein/repos/github.com/takkii/ruby-dictionary3/autoload/source/ruby_method_deoplete

