" pum#visible() が真で、ポップアップの選択肢を上下移動します。
" pum#visible() が偽で、｛カーソルが行頭、又はカーソル直前が空白｝なら、単に<Up>,<Down>します。そうでなければddcのポップアップを開きます。
" [補足] col('.') <= 1 は、カーソルが行頭の場合、真です。
" [補足] getline('.')[col('.') - 2] =~# '\s' は、カーソルの直前が空白の場合、真です。
" [補足] <Bar><Bar> は || (OR演算子) を意味します。
inoremap <silent><expr> <C-p>  pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ? '<Up>'   : ddc#map#manual_complete()
inoremap <silent><expr> <C-n>  pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' : (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ? '<Down>' : ddc#map#manual_complete()

" pum#visible() の状態によらず call pum#map#insert_relativeします。
" [補足] 最小構成のvimにおけるインサートモードでの <C-j>、<C-k> は機能しなくなります。
inoremap <silent> <C-k>  <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <silent> <C-j>  <Cmd>call pum#map#insert_relative(+1)<CR>

" pum#visible() が真なら、ポップアップの選択肢を上下移動します。
" pum#visible() が偽なら、単に<Up>,<Down>します。
inoremap <silent><expr> <Up>   pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' : '<Up>'
inoremap <silent><expr> <Down> pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : '<Down>'

inoremap <silent><expr> <CR>   pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'
" FIXME: <Esc>を押した時にpum#map#cancel()しつつ、ノーマルモードに戻りたい。
" inoremap <silent><expr> <Esc>  pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<Esc>'

"call ddc#custom#patch_global('autoCompleteEvents', [
"\ 'TextChangedI',
"\ 'TextChangedP',
"\ 'CmdlineEnter',
"\ 'CmdlineChanged',
"\ ])

call ddc#custom#patch_global('sources', [
\ 'nvim-lsp',
\ 'around',
\ 'file',
\ ])

call ddc#custom#patch_global('sourceOptions', {'_': {'minAutoCompleteLength': 2, 'matchers': ['matcher_fuzzy'], 'sorters': ['sorter_fuzzy'], 'converters': ['converter_fuzzy']}})
call ddc#custom#patch_global('sourceOptions', {'file': {'mark': 'ddc-file', 'isVolatile': v:true, 'forceCompletionPattern': '\S/\S*'}})
call ddc#custom#patch_global('sourceOptions', {'around': {'mark': 'ddc-arround', 'matchers': ['matcher_fuzzy']}})
call ddc#custom#patch_global('sourceOptions', {'nvim-lsp': {'mark': 'lsp', 'forceCompletionPattern': '\.\w*|:\w*|->\w*'}})

call ddc#custom#patch_global('filterParams', {'matcher_fuzzy': {'camelcase': v:true}})
call ddc#custom#patch_global('filterParams', {'converter_fuzzy': { 'hlGroup': 'SpellBad'}})

call ddc#custom#patch_global('sourceParams', {'around': {'maxSize': 500}})
call ddc#custom#patch_global('sourceParams', {'nvim-lsp': {'kindLabels': {'Class': 'c'}}})

" ddc-file
call ddc#custom#patch_filetype(['ps1', 'dosbatch', 'autohotkey', 'registry'], {'sourceOptions': {'file': {'forceCompletionPattern': '\S\\\S*', }, }, })
call ddc#custom#patch_filetype(['ps1', 'dosbatch', 'autohotkey', 'registry'], {'sourceParams': {'file': {'mode': 'win32', }, }})

call ddc#custom#patch_global('ui', 'pum')
call ddc#custom#patch_global({'keywordPattern': '[a-zA-Z_]\w*', })

" Use ddc.
call ddc#enable()

