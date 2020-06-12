colors256_sample()  {
  for color in {0..255} ; do
    printf "[\e[38;5;%sm %3s \e[0m" $color $color; printf "|\e[48;5;%sm %3s \e[0m]" $color $color
    [[ $((($color + 1) % 6)) -eq 4 ]] && echo
  done
}
