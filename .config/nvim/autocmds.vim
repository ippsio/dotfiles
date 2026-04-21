"augroup vim-start
"  autocmd!
"  autocmd VimEnter * silent! clearjumps
"augroup END
augroup MyDiffExitDetector
  autocmd!
  autocmd WinClosed * call s:MaybeBdeleteDiff(expand('<afile>'))
augroup END

function! s:MaybeBdeleteDiff(winid_str) abort
  let winid = str2nr(a:winid_str)
  let bufnr = winbufnr(winid)
  if bufnr == -1 | return | endif

  " diffなウインドウのバッファの一覧
  let diff_bufs = map(filter(range(1, winnr('$')), 'getwinvar(v:val, "&diff")'), 'winbufnr(v:val)')

  " diffなウインドウのバッファの一覧に、winid(今回閉じられたウインドウのバッファ)が無い場合、即時return
  if index(diff_bufs, bufnr) == -1 | return | endif

  " lsコマンドの結果として得られるバッファの一覧
  let listed_bufs = map(filter(getbufinfo(), 'v:val.listed'), 'v:val.bufnr')

  " バッファをbdelete!します。
  if !bufexists(bufnr) | return | endif
  execute 'bdelete!' bufnr

  " 削除された分のバッファを、それぞれのバッファの一覧から差し引きます。
  let diff_bufs = filter(diff_bufs, 'v:val != bufnr')
  let listed_bufs = filter(listed_bufs, 'v:val != bufnr')

  " diff_bufs
  " のサイズは1になっているはずですが、例外があるかどうか調べられていないので、一旦サイズをチェックしておきます。
  if len(diff_bufs) != 1 | return | endif

  if diff_bufs == listed_bufs
    " この場合、bdelete!するとvimによって新しい[No Name]バッファが作成されてしまいます。それは困るのでquitします。
    quit
  else
    " この場合、bdelete!すると残りのdiffなバッファを閉じます。これにより、diffバッファを綺麗に削除できたはずです。
    if !bufexists(diff_bufs[0]) | return | endif
    execute 'bdelete!' diff_bufs[0]
  endif
endfunction

augroup markdown_indent
  autocmd!
  autocmd FileType markdown setlocal indentexpr=
  autocmd FileType markdown setlocal shiftwidth=2
  autocmd FileType markdown setlocal softtabstop=2
  autocmd FileType markdown setlocal tabstop=2
augroup END
let s:in_codeblock = 0
function! MyMarkdownFoldExpr()
  let line = getline(v:lnum)
  let line_next = getline(v:lnum+1)

  if l:line =~ '^```'
    let s:in_codeblock = !s:in_codeblock
    return '='
  elseif s:in_codeblock
    return '='
  elseif line =~ '^#\{1,2} '
    " # とか ## で始まる行はfoldlevelを一律に1ってことにする。
    " こういうパートは初期状態で折りたたまれないようにする(foldlevel=1)
    return '>1'
  elseif line =~ '^#\{3,} '
    " ### とか #### とか ##### とかで始まる行はfoldlevelを一律に2ってことにする。
    " こういうパートは初期状態で折りたたまれるようにする(foldlevel=1)
    " また、### " の深さによらず折りたたまれ過ぎないようにする。見通しを良くする。何度も折りたたみを開くのは苦痛。
    return '>2'
  elseif line == ''
    if line_next == ''
      return '<0'
    else
      return '='
    endif
  else
    return '='
  endif
endfunction

function! MyMarkdownFoldText()
  let heading = substitute(getline(v:foldstart), '^#\+', '', '')
  let level = strlen(matchstr(getline(v:foldstart), '^#\+'))
  let indent = repeat('#', level)
  let rows = ' (' . string(v:foldend-v:foldstart+1) . '行) '
  let title = substitute(heading, '^ ', ' ', '')
  let fill = repeat('-', winwidth(0) - strwidth(indent . title) - 4)
  return indent . title . rows . ' ' . fill
endfunction

"""augroup markdown_folds
"""  autocmd!
"""  autocmd FileType markdown setlocal foldopen=block,mark,percent,quickfix,search,tag,undo
"""  autocmd FileType markdown setlocal foldmethod=expr
"""  autocmd FileType markdown setlocal foldexpr=MyMarkdownFoldExpr()
"""  autocmd FileType markdown setlocal foldtext=MyMarkdownFoldText()
"""  autocmd FileType markdown setlocal foldlevel=1
"""  autocmd FileType markdown setlocal foldenable
"""  autocmd FileType markdown setlocal foldminlines=0
"""  autocmd FileType markdown setlocal foldcolumn=0
"""augroup END

"""augroup QfAutoCommands
"""  autocmd!
"""  " vim上でのgrep, vimgrep, rg(ripgrep)の結果を、即quickfixウインドウに表示する
"""  au QuickFixCmdPost *grep* cwindow
"""
"""  """ " Quickfixのバッファから抜ける時は、Quickfixを自動的に閉じる。
"""  """ au BufLeave * if &filetype == 'qf' | ccl | endif
"""augroup END

augroup vim-quickfix
  " 残ったバッファがquickfixのみだった場合、vimを閉じる。
  autocmd BufEnter * if winnr('$') == 1 && &buftype == 'quickfix' | q | endif
augroup END

augroup vimrc-highlight
  " 大きなファイルだったら先頭の100行位でファイルタイプを解析する。
  autocmd!
  autocmd Syntax conf if 10000 < line('$') | syntax sync minlines=100 | endif

  " .slimなファイルのファイルタイプがslimであると、vimが気づいてくれない時があったので、その対策。
  " autocmd BufNewFile,BufRead *.slim setlocal filetype=slim

  " .coffeeなファイルのファイルタイプがcoffeeであると、vimが気づいてくれない時があったので、その対策。
  autocmd BufNewFile,BufRead *.coffee setlocal filetype=coffee

  " .csvなファイルのファイルタイプがcsvであると、vimが気づいてくれない時があったので、その対策。
  autocmd BufNewFile,BufRead *.csv setlocal filetype=csv
  autocmd BufNewFile,BufRead *.tsv setlocal filetype=tsv

  " .tomlなファイルのファイルタイプはvimとして扱った方が個人的にシンタックスハイライトが好み
  "autocmd BufNewFile,BufRead *.toml setlocal filetype=vim

  " ft=*.rb,pythonなら、コード規約遵守のための縦線を引く(140桁目位に）。
  autocmd BufRead,BufEnter,BufWinEnter *.rb,*.rake,*.py let &colorcolumn=join(range(141, 141), ",")

augroup END

augroup fileTypeIndent
  autocmd!

  autocmd FileType vim setlocal indentexpr=
  " ある行をコメントアウトしたくて「#」を打った瞬間、vimが気を利かせてインデントを整える事がある。これが好きじゃないので止まってもらう。
  autocmd FileType yaml setlocal indentkeys=
augroup END

augroup windowResize
  autocmd!
  autocmd VimResized * wincmd =
augroup END

"""augroup aufugitive
"""  autocmd!
"""
"""  autocmd BufLeave * call MaybeCloseFugitiveBlame()
"""  fun MaybeCloseFugitiveBlame()
"""    if &ft == "fugitiveblame"
"""      call feedkeys(":b%<CR>:gq<CR>", "n")
"""    endif
"""  endfun
"""augroup END

augroup FileTypeRuby
  autocmd!
  " @hoge のような変数に対し、先頭の@も単語として扱ってもらう。
  au FileType ruby setlocal iskeyword+=@-@

  " save! のような末尾の!も、区切り文字ではなく単語として扱ってもらう。
  au FileType ruby setlocal iskeyword+=?

  " validate? のような末尾の?も、区切り文字ではなく単語として扱ってもらう。
  au FileType ruby setlocal iskeyword+=!

  au FileType ruby setlocal 
    \ foldmethod=indent
    \ foldlevel=99
    \ foldcolumn=0
    \ foldenable
  " これは無いほうが使いやすかったのでコメントアウト
  " " hoge.map(&:fuga) の中身の &:fuga を、単語として扱ってもらう。
  " " au FileType ruby setlocal iskeyword+=:
  " " au FileType ruby setlocal iskeyword+=&

  " 言語ごとのインデントを無効化
  " 例えばerb編集中に、以下のspanとidの間に改行を入れると、fugaまで勝手にインデントが効いてしまうのを防ぎたい。
  " [改行前]
  " <p>
  "   fuga: <span id="hoge">
  " </p>
  "
  " [改行後] fugaまでインデントされてしまう。
  " <p>
  " fuga: <span
  " id="hoge">
  " </p>
  au FileType eruby setlocal indentexpr=
augroup END

augroup FileTypeGitCommit
  autocmd!
  au FileType gitcommit setlocal tw=7
augroup END

augroup AutocmdEventVisualize
   autocmd!
   "autocmd BufAdd * :echo 'BufAdd'
   "autocmd BufCreate * :echo 'BufCreate'
   "autocmd BufDelete * :echo 'BufDelete'
   "autocmd BufEnter * :echo 'BufEnter'
   "autocmd BufFilePost * :echo 'BufFilePost'
   "autocmd BufFilePre * :echo 'BufFilePre'
   "autocmd BufHidden * :echo 'BufHidden'
   "autocmd BufLeave * :echo 'BufLeave'
   "autocmd BufNew * :echo 'BufNew'
   "autocmd BufNewFile * :echo 'BufNewFile'
   "autocmd BufRead * :echo 'BufRead'
   "autocmd BufReadCmd * :echo 'BufReadCmd'
   "autocmd BufReadPost * :echo 'BufReadPost'
   "autocmd BufReadPre * :echo 'BufReadPre'
   "autocmd BufUnload * :echo 'BufUnload'
   "autocmd BufWinEnter * :echo 'BufWinEnter'
   "autocmd BufWinLeave * :echo 'BufWinLeave'
   "autocmd BufWipeout * :echo 'BufWipeout'
   "autocmd BufWrite * :echo 'BufWrite'
   "autocmd BufWriteCmd * :echo 'BufWriteCmd'
   "autocmd BufWritePost * :echo 'BufWritePost'
   "autocmd BufWritePre * :echo 'BufWritePre'
   "autocmd CmdUndefined * :echo 'CmdUndefined'
   "autocmd CmdlineChanged * :echo 'CmdlineChanged'
   "autocmd CmdlineEnter * :echo 'CmdlineEnter'
   "autocmd CmdlineLeave * :echo 'CmdlineLeave'
   "autocmd CmdwinEnter * :echo 'CmdwinEnter'
   "autocmd CmdwinLeave * :echo 'CmdwinLeave'
   "autocmd ColorScheme * :echo 'ColorScheme'
   "autocmd ColorSchemePre * :echo 'ColorSchemePre'
   "autocmd CompleteChanged * :echo 'CompleteChanged'
   "autocmd CompleteDone * :echo 'CompleteDone'
   "autocmd CursorHold * :echo 'CursorHold'
   "autocmd CursorHoldI * :echo 'CursorHoldI'
   "autocmd CursorMoved * :echo 'CursorMoved'
   "autocmd CursorMovedI * :echo 'CursorMovedI'
   "autocmd DiffUpdated * :echo 'DiffUpdated'
   "autocmd DirChanged * :echo 'DirChanged'
   "autocmd EncodingChanged * :echo 'EncodingChanged'
   "autocmd ExitPre * :echo 'ExitPre'
   "autocmd FileAppendCmd * :echo 'FileAppendCmd'
   "autocmd FileAppendPost * :echo 'FileAppendPost'
   "autocmd FileAppendPre * :echo 'FileAppendPre'
   "autocmd FileChangedRO * :echo 'FileChangedRO'
   "autocmd FileChangedShell * :echo 'FileChangedShell'
   "autocmd FileChangedShellPost * :echo 'FileChangedShellPost'
   "autocmd FileReadCmd * :echo 'FileReadCmd'
   "autocmd FileReadPost * :echo 'FileReadPost'
   "autocmd FileReadPre * :echo 'FileReadPre'
   "autocmd FileType * :echo 'FileType'
   "autocmd FileWriteCmd * :echo 'FileWriteCmd'
   "autocmd FileWritePost * :echo 'FileWritePost'
   "autocmd FileWritePre * :echo 'FileWritePre'
   "autocmd FilterReadPost * :echo 'FilterReadPost'
   "autocmd FilterReadPre * :echo 'FilterReadPre'
   "autocmd FilterWritePost * :echo 'FilterWritePost'
   "autocmd FilterWritePre * :echo 'FilterWritePre'
   "autocmd FocusGained * :echo 'FocusGained'
   "autocmd FocusLost * :echo 'FocusLost'
   "autocmd FuncUndefined * :echo 'FuncUndefined'
   "autocmd GUIEnter * :echo 'GUIEnter'
   "autocmd GUIFailed * :echo 'GUIFailed'
   "autocmd InsertChange * :echo 'InsertChange'
   "autocmd InsertCharPre * :echo 'InsertCharPre'
   "autocmd InsertEnter * :echo 'InsertEnter'
   "autocmd InsertLeave * :echo 'InsertLeave'
   "autocmd MenuPopup * :echo 'MenuPopup'
   "autocmd OptionSet * :echo 'OptionSet'
   "autocmd QuickFixCmdPost * :echo 'QuickFixCmdPost'
   "autocmd QuickFixCmdPre * :echo 'QuickFixCmdPre'
   "autocmd QuitPre * :echo 'QuitPre'
   "autocmd RemoteReply * :echo 'RemoteReply'
   "autocmd SessionLoadPost * :echo 'SessionLoadPost'
   "autocmd ShellCmdPost * :echo 'ShellCmdPost'
   "autocmd ShellFilterPost * :echo 'ShellFilterPost'
   "autocmd SourceCmd * :echo 'SourceCmd'
   "autocmd SourcePost * :echo 'SourcePost'
   "autocmd SourcePre * :echo 'SourcePre'
   "autocmd SpellFileMissing * :echo 'SpellFileMissing'
   "autocmd StdinReadPost * :echo 'StdinReadPost'
   "autocmd StdinReadPre * :echo 'StdinReadPre'
   "autocmd SwapExists * :echo 'SwapExists'
   "autocmd Syntax * :echo 'Syntax'
   "autocmd TabClosed * :echo 'TabClosed'
   "autocmd TabEnter * :echo 'TabEnter'
   "autocmd TabLeave * :echo 'TabLeave'
   "autocmd TabNew * :echo 'TabNew'
   "autocmd TermChanged * :echo 'TermChanged'
   "autocmd TermResponse * :echo 'TermResponse'
   "autocmd TextChanged * :echo 'TextChanged'
   "autocmd TextChangedI * :echo 'TextChangedI'
   "autocmd TextChangedP * :echo 'TextChangedP'
   "autocmd TextYankPost * :echo 'TextYankPost'
   "autocmd User * :echo 'User'
   "autocmd VimEnter * :echo 'VimEnter'
   "autocmd VimLeave * :echo 'VimLeave'
   "autocmd VimLeavePre * :echo 'VimLeavePre'
   "autocmd VimResized * :echo 'VimResized'
   "autocmd VimResume * :echo 'VimResume'
   "autocmd VimSuspend * :echo 'VimSuspend'
   "autocmd WinEnter * :echo 'WinEnter'
   "autocmd WinLeave * :echo 'WinLeave'
   "autocmd WinNew * :echo 'WinNew'
augroup END
