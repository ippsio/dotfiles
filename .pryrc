##!/usr/bin/env ruby

def set(sym, val)
  CodeRay::Encoders::Terminal::TOKEN_COLORS[sym] = val
end
if defined?(PryByebug)
  set(:annotation, "\e[34m")
  set(:attribute_name, "\e[35m")
  set(:attribute_value, "\e[31m")
  set(:binary, {:self=>"\e[31m", :char=>"\e[1;31m", :delimiter=>"\e[1;31m"})
  set(:change, {:self=>"\e[44m", :change=>"\e[37;44m"})
  set(:char, {:self=>"\e[35m", :delimiter=>"\e[1;35m"})
  set(:class, "\e[1;35;4m")
  set(:class_variable, "\e[36m")
  set(:color, "\e[32m")
  set(:comment, "\e[38;5;123m\e[48;5;23m")
  set(:constant, "\e[1;34;4m")
  set(:debug, "\e[1;37;44m")
  set(:decorator, "\e[35m")
  set(:definition, "\e[38;5;170m")
  set(:delete, {:self=>"\e[41m", :delete=>"\e[1;31;41m", :eyecatcher=>"\e[101m"})
  set(:directive, "\e[33m")
  set(:docstring, "\e[31m")
  set(:doctype, "\e[1;34m")
  set(:done, "\e[1;30;2m")
  set(:entity, "\e[31m")
  set(:error, "\e[1;37;41m")
  set(:escape, nil)
  set(:exception, "\e[1;31m")
  set(:float, "\e[1;35m")
  set(:function, "\e[1;34m")
  set(:global_variable, "\e[1;32m")
  set(:head, {:self=>"\e[45m", :filename=>"\e[37;45m"})
  set(:hex, "\e[1;36m")
  set(:id, "\e[1;34m")
  set(:imaginary, "\e[1;34m")
  set(:important, "\e[1;31m")
  set(:include, "\e[31m")
  set(:insert, {:self=>"\e[42m", :insert=>"\e[1;32;42m", :eyecatcher=>"\e[102m"})
  set(:integer, "\e[38;5;168m")
  set(:key, {:self=>"\e[35m", :char=>"\e[1;35m", :delimiter=>"\e[1;35m"})
  set(:keyword, "\e[32m")
  set(:label, "\e[1;33m")
  set(:local_variable, "\e[33m")
  set(:method, "\e[38;5;14m")
  set(:namespace, "\e[1;35m")
  set(:octal, "\e[1;34m")
  set(:predefined, "\e[36m")
  set(:predefined_constant, "\e[1;36m")
  set(:predefined_type, "\e[1;32m")
  set(:preprocessor, "\e[1;36m")
  set(:pseudo_class, "\e[1;34m")
  set(:regexp, {:self=>"\e[35m", :delimiter=>"\e[1;35m", :modifier=>"\e[35m", :char=>"\e[1;35m"})
  set(:reserved, "\e[32m")
  set(:shell, {:self=>"\e[33m", :char=>"\e[1;33m", :delimiter=>"\e[1;33m", :escape=>"\e[1;33m"})
  set(:string, {:self=>"\e[31m", :modifier=>"\e[1;31m", :char=>"\e[1;35m", :delimiter=>"\e[1;31m", :escape=>"\e[1;31m"})
  set(:symbol, "\e[38;5;196m\e[48;5;52m")
  set(:tag, "\e[32m")
  set(:type, "\e[38;5;48m\e[48;5;16m")
  set(:value, "\e[36m")
  set(:variable, "\e[34m")

  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 'ss', 'show-source'
  # Pry.commands.alias_command "\n", 'whereami'
  Pry::Commands.command /^$/, "repeat last command" do
    # _pry_.run_command Pry.history.to_a.last
    # 
    # 誤爆するので一旦コメントアウト
    # pry_instance.run_command Pry.history.to_a.last
  end
end

