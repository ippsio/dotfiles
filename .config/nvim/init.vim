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

