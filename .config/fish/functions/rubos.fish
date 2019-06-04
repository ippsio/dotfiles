# .rubocop.ymlと.rubucop_strict.ymlを使ってrubocopを実行する
function rubos
  for FILE in .rubocop.yml .rubocop_strict.yml
    echo -en "\e[33;40;1m"
    echo -e "============================================"
    echo -e " bundle exec rubocop -c $FILE"
    echo -e "============================================"
    echo -en "\e[m"
    pwd
    bundle exec rubocop -c $FILE $argv
  end
end

