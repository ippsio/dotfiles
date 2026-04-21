" カーソル下のhighlight情報を表示する
function! s:part(s, fgbg, type)
  let l:attr = synIDattr(a:s, a:fgbg, a:type)
  return l:attr ? " " . a:type . a:fgbg . "=" . l:attr : ""
endfunction

function! s:attr(transparent)
  let l:s = synID(line("."), col("."), 1)
  let l:s = a:transparent ? synIDtrans(l:s) : l:s
  return synIDattr(l:s,"name").s:part(l:s, "fg", "cterm").s:part(l:s, "bg", "cterm").s:part(l:s, "fg", "gui").s:part(l:s, "bg", "gui")
endfunction

function! s:syn_info()
  let l:prev_attr = ""
  let l:curr_attr = ""
  for i in [0, 1]
    let l:curr_attr = s:attr(i)
    if l:curr_attr == l:prev_attr
      :break
    endif
    echo "hi " . l:curr_attr
    let l:prev_attr = l:curr_attr
  endfor
endfunction

command! Hi call s:syn_info()

