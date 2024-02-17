if !jetpack#tap(expand('<script>:t:r'))
  finish " このファイル名に該当するプラグインがJetpack上で有効でない場合finishします
endif

" disable the default highlight group
let g:conflict_marker_highlight_group = ''

" Include text after begin and end markers
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'

highlight ConflictMarkerBegin cterm=bold ctermfg=5 ctermbg=53
highlight ConflictMarkerOurs ctermbg=53
highlight ConflictMarkerTheirs ctermbg=4
highlight ConflictMarkerEnd cterm=bold ctermfg=18 ctermbg=4
highlight ConflictMarkerCommonAncestorsHunk ctermbg=166

