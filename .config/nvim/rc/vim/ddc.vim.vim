inoremap <silent> <C-k>  <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <silent> <C-j>  <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <silent><expr> <Up>   pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' : '<Up>'
inoremap <silent><expr> <Down> pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : '<Down>'
inoremap <silent><expr> <CR>   pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'
inoremap <silent><expr> <Esc> pum#visible() ? '<Cmd>call pum#map#cancel()<CR><Esc>' : '<Esc>'

call ddc#custom#patch_global('ui', 'pum')
call ddc#custom#patch_global('autoCompleteEvents', ['TextChangedP', 'TextChangedI', 'CmdlineEnter', 'CmdlineChanged'])
call ddc#custom#patch_global('sources', ['around', 'lsp'])
call ddc#custom#patch_filetype(['ps1', 'dosbatch', 'autohotkey', 'registry'],
\ #{
\   sourceOptions: #{file: #{forceCompletionPattern: '\S\\\S*'}},
\    sourceParams: #{file: #{mode: 'win32'}}
\ })

call ddc#custom#patch_global('sourceParams',
\ #{
\   matcher_head: #{splitMode: 'word'},
\   around: #{maxSize: 500},
\   lsp: #{
\     snippetEngine: denops#callback#register({
\       body -> vsnip#anonymous(body)
\     }),
\     enableResolveItem: v:true,
\     enableAdditionalTextEdit: v:true,
\   }
\ })

call ddc#custom#alias('filter', 'matcher_initial', 'matcher_head')
call ddc#custom#alias('filter', 'matcher_first_2', 'matcher_head')
call ddc#custom#alias('filter', 'matcher_first_3', 'matcher_head')
call ddc#custom#alias('filter', 'matcher_lazy_1', 'matcher_head')
call ddc#custom#alias('filter', 'matcher_lazy_2', 'matcher_head')
call ddc#custom#patch_global('filterParams',
\ #{
\   matcher_initial: #{maxMatchLength: 1},
\   matcher_first_2: #{maxMatchLength: 2},
\   matcher_first_3: #{maxMatchLength: 3},
\   matcher_lazy_1: #{maxMatchLength: -1},
\   matcher_lazy_2: #{maxMatchLength: -2},
\   matcher_fuzzy: #{camelcase: v:true, splitMode: 'word'},
\   converter_fuzzy: #{hlGroup: 'MiniTrailspace'}
\ })
"   matcher_fuzzy: #{camelcase: v:true, splitMode: 'character'},

call ddc#custom#patch_global('sourceOptions',
\ #{
\   _: #{
\     minAutoCompleteLength: 1,
\     matchers: ['matcher_initial', 'matcher_fuzzy'],
\     sorters: ['sorter_fuzzy'],
\     converters: ['converter_fuzzy']
\   },
\   around: #{mark: 'A'},
\   file:   #{mark: 'F', isVolatile: v:true, forceCompletionPattern: '\S/\S*'},
\   lsp:    #{mark: 'LSP', forceCompletionPattern: join(['\.\w*', '->\w*'], '|')}
\ })

call ddc#enable()

