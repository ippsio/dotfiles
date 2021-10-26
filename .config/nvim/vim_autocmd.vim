"""augroup QfAutoCommands
"""  autocmd!
"""  " vim上でのgrep, vimgrep, rg(ripgrep)の結果を、即quickfixウインドウに表示する
"""  au QuickFixCmdPost *grep* cwindow
"""
"""  """ " Quickfixのバッファから抜ける時は、Quickfixを自動的に閉じる。
"""  """ au BufLeave * if &filetype == 'qf' | ccl | endif
"""augroup END

augroup vimrc-highlight
  " 大きなファイルだったら先頭の100行位でファイルタイプを解析する。
  autocmd!
  autocmd Syntax conf if 10000 < line('$') | syntax sync minlines=100 | endif

  autocmd BufRead,BufEnter,BufWinEnter * call DoWellByFileType()
  fun DoWellByFileType()
    if &ft == ""
      let &colorcolumn=join(range(0, 0), ",")

    elseif match(["ruby", "python"], &ft) >= 0
        " ファイルタイプによって、コード規約遵守のための縦線を引く(120桁目位に）。
        let &colorcolumn=join(range(121, 121), ",")

    elseif match(["yaml"], &ft) >= 0
      let &colorcolumn=join(range(0, 0), ",")
      " setlocal nosmartindent
      " setlocal noautoindent
      setlocal indentkeys-=0#

    else
      let &colorcolumn=join(range(0, 0), ",")
    endif
  endfun
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



""" if has('mac')
"""   augroup MyIMEGroup
"""     autocmd!
"""     """ " IMEをOFFにする(102=英数key)（インサートモード抜け時とフォーカス取得／開放時）
"""     """ au InsertLeave,FocusGained,FocusLost * :call system('osascript -e "tell application \"System Events\" to key code 102"')
"""
"""     " IMEをOFFにする(102=英数key)（インサートモード抜け時だけで十分かもしれない）
"""     " au InsertLeave * :call system('osascript -e "tell application \"System Events\" to key code 102"')
"""
"""     " もしかしてこれってかなりvimの動きを遅くするのかも？
"""     " というわけでちょっとコメントアウトして様子を見てみる。
"""     " au InsertLeave * :call system('osascript -e "tell application \"System Events\" to key code 102"')
""" endif

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
