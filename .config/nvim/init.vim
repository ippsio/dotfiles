runtime! vars.vim
runtime! settings.vim
runtime! remaps.vim
runtime! jetpack.vim
runtime! autocmds.vim
"runtime! highlights.vim
try
  runtime! colorscheme.vim
catch
endtry
runtime! rc/functions/Hi.vim
" ホバーウィンドウのブレンドレベルを設定
"set winblend=0

hi MarkdownHr gui=underline
sign define h1_linehl linehl=HelpviewTitle
sign define h2_linehl linehl=HelpviewTitle
sign define h3_linehl linehl=HelpviewHeading1
sign define h4_linehl linehl=TreeSitterContext
"sign define hr_linehl linehl=MiniTrailspace
sign define hr_linehl linehl=MarkdownHr
function! SignPlace(lnum, highlight_name)
  execute 'sign place' a:lnum 'line=' . a:lnum . ' name=' . a:highlight_name . ' group=markdown_headers buffer=' . bufnr('%')
endfunction
function! HighlightMarkdownHeaders()
  sign unplace * group=markdown_headers

  for lnum in range(1, line('$'))
    let line_text = getline(lnum)
    if line_text =~ '^# '
      call SignPlace(lnum, 'h1_linehl')
    elseif line_text =~ '^## '
      call SignPlace(lnum, 'h2_linehl')
    elseif line_text =~ '^### '
      call SignPlace(lnum, 'h3_linehl')
    "elseif line_text =~ '^#### '
    "  call SignPlace(lnum, 'h4_line')
    elseif line_text =~ '^\-\-\-$'
      call SignPlace(lnum, 'hr_linehl')
    endif
  endfor
endfunction

autocmd BufReadPost,BufWritePost *.md call HighlightMarkdownHeaders()


function! EchoSelection() range
  " 選択範囲をレジスタに保存
  silent execute a:firstline . "," . a:lastline . "y"
  " echo で表示
  let l:selection = getreg('"')
  "execute "!echo " . shellescape(l:selection) . " | sqlformat --reindent --keywords=upper - "
  echo l:selection
  execute "!echo " . shellescape(l:selection)
endfunction

command! -range EchoSel <line1>,<line2>call EchoSelection()
command! -range -bang -nargs=* EchoSelectedText call EchoSelectedTextFunction(<line1>, <line2>, <f-args>)

function! EchoSelectedTextFunction(line1, line2, ...)
  let selected_text = join(getline(a:line1, a:line2), "\n")
  echo system('echo ' . shellescape(selected_text) . " | sqlformat -k upper -")
endfunction

"
command! -range -nargs=1 ReplaceWith call ReplaceWithCommand(<line1>, <line2>, <f-args>)
function! ReplaceWithCommand(line1, line2, cmd)
echo a:line1
echo a:line2
echo a:cmd
  " 選択範囲のテキストを取得
  let lines = getline(a:line1, a:line2)
  let joined = join(lines, "\n")
  echo joined

  " 外部コマンドを実行して結果を取得
  let result = system(a:cmd . ' "' . joined . '"')
  echo result

  " 結果で元の範囲を置き換え
  call setline(a:line1, split(result, "\n"))

  " 必要なら余分な行を削除
  if a:line2 > a:line1 + len(split(result, "\n")) - 1
    execute (a:line1 + len(split(result, "\n"))) . ',' . a:line2 . 'delete _'
  endif
endfunction
"select * from hoges where id=3
"select * from hoges where id=3
"
"command! -range=% -nargs=0 FormatSQL <line1>,<line2> !<c-space>echo '<s-v>'.join(getline(<line1>, <line2>), "\n")<cr> | sqlformat -k upper - | set clipboard=unnamedplus | normal! "_dP
