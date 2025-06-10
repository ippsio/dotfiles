for s:rcfile_realpath in (split(glob(expand('<script>:h') . '/rc/{vim,lua}/*.{vim,lua}')))
  if jetpack#tap(fnamemodify(s:rcfile_realpath, ':t:r'))
    execute 'runtime! rc/' . fnamemodify(s:rcfile_realpath, ':e') . '/' . fnamemodify(s:rcfile_realpath, ':t')
  else
    " echomsg 'Jetpackは' . s:plugin . 'を認識してません。' . s:rcfile_full . 'はruntime!しません。'
  endif
endfor

