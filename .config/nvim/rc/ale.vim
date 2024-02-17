if !jetpack#tap(expand('<script>:t:r'))
  finish " このファイル名に該当するプラグインがJetpack上で有効でない場合finishします
endif

let g:ale_linters = {
\   'ruby': ['rubocop'],
\   'json': ['jsonlint'],
\}

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_enter = 1

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0

let g:ale_completion_autoimport = 0
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_linters_explicit = 1

" 以下の設定を効かせるにはg:ale_use_neovim_diagnostics_api が0である必要がありそう。
"let g:ale_use_neovim_diagnostics_api = 1
"let g:ale_sign_error = 'Er'
"hi ALEError ctermbg=168
"hi ALESignColumnWithErrors ctermbg=168
""
"let g:ale_sign_warning = 'Wa'
"hi ALEWarning ctermbg=DarkMagenta
"hi ALESignColumnWithoutErrors ctermbg=DarkMagenta

