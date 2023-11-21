if !jetpack#tap(expand('<sfile>:t:r')) | finish | endif

let g:ale_linters = {
\   'ruby': ['rubocop'],
\   'json': ['jsonlint'],
\}

""" " 保存時だけチェックする（編集中にチェックしない。ファイルオープン時にチェックしない）
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0

let g:ale_completion_autoimport = 0
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_linters_explicit = 1

let g:ale_sign_error = 'Er'
hi ALEError ctermbg=168
hi ALESignColumnWithErrors ctermbg=168

let g:ale_sign_warning = 'Wa'
hi ALEWarning ctermbg=DarkMagenta
hi ALESignColumnWithoutErrors ctermbg=DarkMagenta

