" RSpec.vim mappings
"let g:rspec_command = "!date; bundle exec rspec {spec}"
let g:rspec_command = "Dispatch bundle exec rspec --seed=5960 -f p {spec}"

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
