#!/usr/bin/env bash
script_path=$(dirname "$0")
EN_RATE=300
JA_RATE=260
EN_SPEAKER=Samantha
JA_SPEAKER=Kyoko
N=${1:-0}
speech() {
  lineno="$1"
  speaker="$2"
  line="$3"
  en=$(echo "$line"| awk -F'\t' '{ printf "%s", $1 }')
  ja=$(echo "$line"| awk -F'\t' '{ printf "%s", $2 }')
  printf "(%s)%d: %s ＝ %s\n" "$(date +'%H:%M:%S')" "$lineno" "$en" "$ja"
  say --rate="$EN_RATE" -v "$speaker" "$en"
  if [[ -n "$ja" ]]; then
    say --rate="$JA_RATE" -v "$JA_SPEAKER" "$ja"
  fi
}
speech_sample() {
  declare voices=()
  voices+=(Carmit)    # Carmit              he_IL    # שלום, שמי כרמית.
  voices+=(Daniel)    # Daniel              en_GB    # Hello! My name is Daniel.
  voices+=(Fred)      # Fred                en_US    # Hello! My name is Fred.
  voices+=(Junior)    # Junior              en_US    # Hello! My name is Junior.
  voices+=(Karen)     # Karen               en_AU    # Hi my name is Karen
  voices+=(Kathy)     # Kathy               en_US    # Hello! My name is Kathy.
  voices+=(Meijia)    # Meijia              zh_TW    # 你好，我叫美佳。
  voices+=(Milena)    # Milena              ru_RU    # Здравствуйте! Меня зовут Милена.
  voices+=(Ralph)     # Ralph               en_US    # Hello! My name is Ralph.
  voices+=(Rishi)     # Rishi               en_IN    # Hello! My name is Rishi.
  voices+=(Samantha)  # Samantha            en_US    # Hello! My name is Samantha.
  sample="Hello, What's going on?"

  for voice in "${voices[@]}"; do
    speech "$voice" "$sample"
  done
}
#speech_sample

lineno="$(( N - 1 ))"
awk "NR >= $N" "$script_path/tango3000.tsv"| while read -r line; do
  lineno=$(( lineno + 1 ))
  speech "$lineno" "$EN_SPEAKER" "$line"
  # sleep 0.05
done

