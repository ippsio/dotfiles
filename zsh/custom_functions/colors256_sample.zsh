colors256_sample()  {
  for type in {0..1}; do for color in {0..3}; do
    [ $type -eq 0 ] && printf "|\e[38;5;%sm%3s\e[0m" $color $color
    [ $type -eq 1 ] && printf "|\e[48;5;%sm%3s\e[0m" $color $color
  done; done; echo; idx=$(($color + 1))

  while [ $idx -lt 255 ]
  do
    for type in {0..1}; do for color in {$idx..$(($idx + 5))}; do
      [ $type -eq 0 ] && printf "|\e[38;5;%sm%3s\e[0m" $color $color
      [ $type -eq 1 ] && printf "|\e[48;5;%sm%3s\e[0m" $color $color
    done; done; echo; idx=$(($color + 1))
  done
}
