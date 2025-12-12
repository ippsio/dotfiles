#!/usr/bin/env zsh
exec gawk -l time '{
  # CSI: ESC [ ... <letter>
  gsub(/\x1B\[[0-9:;<=>?]*[ -/]*[@-~]/, "", $0)

  # OSC: ESC ] ... (BEL または ST)
  gsub(/\x1B\][^\x07\x1B]*(\x07|\x1B\\)/, "", $0)

  # ESC シーケンス（2文字の簡易形式: ESC <char>）
  gsub(/\x1B[@-Z\\-_]/, "", $0)

  ts = sprintf("%f", gettimeofday())
  split(ts, tv, ".")
  printf "%s.%s%s| %s\n", strftime("%Y-%m-%d %H:%M:%S", tv[1]), tv[2], strftime("%z"), $0
  fflush()
}'
