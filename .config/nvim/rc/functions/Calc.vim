" :Calc  選択範囲(または現在行/指定行範囲)を数式として計算し、結果を表示する
"   - visual選択して :Calc  => 選択文字列を評価
"   - 通常モードで :Calc     => 現在行を評価
"   - :3,5Calc               => 3-5行目を結合して評価
" 許可文字のみ通し、空環境の Lua load で評価するので識別子・関数呼び出しは一切効かない
" Lua評価: `/` は常に浮動小数(7/2=3.5)、`^` はべき乗、0x.. と 1e3 表記可

lua << EOF
function _G.CalcEval(text)
  if not text:match('%d') then
    return ''
  end
  -- 英字は 16進(0x..)/指数表記(1e3) 用。それ以外の識別子は空環境で nil になり pcall で落ちる
  if text:match('[^0-9a-fA-FxXeE%.%+%-%*/%%%^%(%)%s]') then
    return ''
  end
  local f = load('return ' .. text, '=calc', 't', {})
  if not f then return '' end
  local ok, v = pcall(f)
  if not ok or type(v) ~= 'number' or v ~= v or v == math.huge or v == -math.huge then
    return ''
  end
  if v == math.floor(v) and math.abs(v) < 2^53 then
    return string.format('%d', v)
  end
  return string.format('%.10g', v)
end
EOF

function! s:Calc(line1, line2, range) abort
  " visual由来(:'<,'>Calc)なら文字単位/矩形の選択範囲を正確に取る
  if a:range == 2 && a:line1 == line("'<") && a:line2 == line("'>") && visualmode() !=# ''
    let l:text = join(getregion(getpos("'<"), getpos("'>"), #{ type: visualmode() }), "\n")
  else
    let l:text = join(getline(a:line1, a:line2), "\n")
  endif
  let l:expr = trim(substitute(l:text, '\_s\+', ' ', 'g'))
  let l:r = v:lua.CalcEval(l:text)
  if l:r ==# ''
    echohl WarningMsg | echo 'Calc: 数式ではない: ' . l:expr | echohl None
  else
    echo l:expr . ' = ' . l:r
  endif
endfunction

command! -range Calc call s:Calc(<line1>, <line2>, <range>)
