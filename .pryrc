##!/usr/bin/env ruby

if defined?(PryByebug)
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:annotation] = "\e[34m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:attribute_name] = "\e[35m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:attribute_value] = "\e[31m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:binary] = {:self=>"\e[31m", :char=>"\e[1;31m", :delimiter=>"\e[1;31m"}
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:change] = {:self=>"\e[44m", :change=>"\e[37;44m"}
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:char] = {:self=>"\e[35m", :delimiter=>"\e[1;35m"}
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:class] = "\e[1;35;4m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:class_variable] = "\e[36m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:color] = "\e[32m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:comment] = "\e[38;5;123m\e[48;5;23m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:constant] = "\e[1;34;4m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:debug] = "\e[1;37;44m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:decorator] = "\e[35m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:definition] = "\e[38;5;170m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:delete] = {:self=>"\e[41m", :delete=>"\e[1;31;41m", :eyecatcher=>"\e[101m"}
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:directive] = "\e[33m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:docstring] = "\e[31m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:doctype] = "\e[1;34m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:done] = "\e[1;30;2m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:entity] = "\e[31m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:error] = "\e[1;37;41m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:escape] = nil
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:exception] = "\e[1;31m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:float] = "\e[1;35m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:function] = "\e[1;34m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:global_variable] = "\e[1;32m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:head] = {:self=>"\e[45m", :filename=>"\e[37;45m"}
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:hex] = "\e[1;36m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:id] = "\e[1;34m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:imaginary] = "\e[1;34m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:important] = "\e[1;31m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:include] = "\e[31m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:insert] = {:self=>"\e[42m", :insert=>"\e[1;32;42m", :eyecatcher=>"\e[102m"}
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:integer] = "\e[38;5;168m\e[48;5;23m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:key] = {:self=>"\e[35m", :char=>"\e[1;35m", :delimiter=>"\e[1;35m"}
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:keyword] = "\e[32m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:label] = "\e[1;33m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:local_variable] = "\e[33m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:method] = "\e[38;5;14m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:namespace] = "\e[1;35m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:octal] = "\e[1;34m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:predefined] = "\e[36m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:predefined_constant] = "\e[1;36m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:predefined_type] = "\e[1;32m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:preprocessor] = "\e[1;36m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:pseudo_class] = "\e[1;34m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:regexp] = {:self=>"\e[35m", :delimiter=>"\e[1;35m", :modifier=>"\e[35m", :char=>"\e[1;35m"}
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:reserved] = "\e[32m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:shell] = {:self=>"\e[33m", :char=>"\e[1;33m", :delimiter=>"\e[1;33m", :escape=>"\e[1;33m"}
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:string] = {:self=>"\e[31m", :modifier=>"\e[1;31m", :char=>"\e[1;35m", :delimiter=>"\e[1;31m", :escape=>"\e[1;31m"}
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:symbol] = "\e[38;5;196m\e[48;5;52m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:tag] = "\e[32m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:type] = "\e[38;5;48m\e[48;5;16m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:value] = "\e[36m"
  CodeRay::Encoders::Terminal::TOKEN_COLORS[:variable] = "\e[34m"
  # def Pry.set_color(sym, fg, bg)
  #   colors.append("\e[38;5;#{fg}m") if fg.present?
  #   colors.append("\e[48;5;#{bg}m") if bg.present?
  #   return if colors.empty?
  #   if CodeRay::Encoders::Terminal::TOKEN_COLORS[sym].is_a?(String)
  #     CodeRay::Encoders::Terminal::TOKEN_COLORS[sym] = colors.join
  #   elsif CodeRay::Encoders::Terminal::TOKEN_COLORS[sym].is_a?(Hash)
  #     CodeRay::Encoders::Terminal::TOKEN_COLORS[sym][:self] = colors.join
  #   end
  #   { sym => colors.join }
  # end

  # Pry.set_color(:comment, 123, 23)
  # Pry.set_color(:symbol, 196, 52)
  # Pry.set_color(:method, 14, nil)
  # Pry.set_color(:definition, 170, nil)
  # Pry.set_color(:type, 226, nil)

  # Step execution into the next line or method.
  Pry.commands.alias_command 's', 'step'

  # Execute the next line within the current stack frame.
  Pry.commands.alias_command 'n', 'next'

  # Execute until current stack frame returns.
  Pry.commands.alias_command 'f', 'finish'

  # Continue program execution and end the pry session.
  Pry.commands.alias_command 'c', 'continue'

  # Show the source for a method or class.
  Pry.commands.alias_command 'ss', 'show-source'

  # Show code surrounding the current context.
  Pry.commands.alias_command "\n", 'whereami'

  Pry::Commands.command /^$/, "repeat last command" do
    _pry_.run_command Pry.history.to_a.last
  end


end

