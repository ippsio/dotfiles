function diff_rbfiles
  git --no-pager branch
  set length (count $argv)
  if test $length -lt 1
    echo -en "\e[31;40;1m"
    echo " specify merge-target-branch at first argument."
    echo -en "\e[m"
  else
    echo -en "\e[33;40;1m"
    echo -e "==============================================================="
    echo -e " LIST OF DIFF OF *.RB FILES AGAINST [$1]"
    echo -e "==============================================================="

    set files_count (git diff $argv[1] --name-only| grep -c '\.rb$')
    echo -e "$files_count found."
    echo -en "\e[m"
    git diff $argv[1] --name-only| grep '\.rb$'
    echo -e ""
  end
end

