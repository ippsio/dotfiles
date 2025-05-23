let g:projectionist_heuristics = {
  \ '*.py':{
  \   'src/*.py': {'alternate': 'tests/{}_test.py', 'type': 'source'},
  \   'tests/*_test.py': {'alternate': 'src/{}.py', 'type': 'test'}}
  \ }

nmap <Leader>a :A<CR>
