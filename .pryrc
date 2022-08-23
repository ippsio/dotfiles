#!/usr/bin/env ruby
if defined?(PryByebug)
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:comment] = "\e[38;5;123m\e[48;5;23m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:definition] = "\e[38;5;170m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:integer] = "\e[38;5;168m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:method] = "\e[38;5;14m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:symbol] = "\e[38;5;196m\e[48;5;52m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:type] = "\e[38;5;48m\e[48;5;16m"

  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 'ss', 'show-source'
end

