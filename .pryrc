#!/usr/bin/env ruby

if defined?(PryByebug)
  # ANSI 16-colors Foreground_color
  fg30_black = 30
  fg31_red = 31
  fg32_green = 32
  fg33_yellow = 33
  fg34_blue = 34
  fg35_magenta = 35
  fg36_cyan = 36
  fg37_white = 37
  fg90_black = 90  #light
  fg91_red = 91  #light
  fg92_green = 92  #light
  fg93_yellow = 93  #light
  fg94_blue = 94  #light
  fg95_magenta = 95  #light
  fg96_cyan = 96  #light
  fg97_white = 97  #light

  # ANSI 16-colors Background_color
  bg40_black = 40
  bg41_red = 41
  bg42_green = 42
  bg43_yellow = 43
  bg44_blue = 44
  bg45_magenta = 45
  bg46_cyan = 46
  bg47_white = 47
  bg100_black = 100  #light
  bg101_red = 101  #light
  bg102_green = 102  #light
  bg103_yellow = 103  #light
  bg104_blue = 104  #light
  bg105_magenta = 105  #light
  bg106_cyan = 106  #light
  bg107_white = 107  #light

  def ansi16(arg1, arg2 = nil)
    if [arg1, arg2].all?(&:present?)
      "\e[#{arg1};#{arg2}m"
    else
      "\e[#{arg1}m"
    end
  end

  def ansi16_bold(arg1, arg2 = nil)
    if [arg1, arg2].all?(&:present?)
      "\e[1;#{arg1};#{arg2}m"
    else
      "\e[1;#{arg1}m"
    end
  end

  def ansi16_bold_underlined(arg1)
    "\e[1;#{arg1};4m"
  end

  def ansi16_bold_dull(arg1)
    "\e1;#{arg1};2m"
  end


  def ansi256_fg(arg1)
    "\e[38;5;#{arg1}m"
  end

  def ansi256_bg(arg1)
    "\e[48;5;#{arg1}m"
  end

  def reset
    "\e[0m"
  end

  original = CodeRay::Encoders::Terminal::TOKEN_COLORS.dup
  {
    debug: ansi16_bold(fg37_white, bg44_blue),
    # annotation: ansi16(fg34_blue),
    annotation: ansi16(fg94_blue),
    attribute_name: ansi16(fg35_magenta),
    attribute_value: ansi16(fg31_red),
    binary: {:self=>ansi16(fg31_red), :char=>ansi16_bold(fg31_red), :delimiter=>ansi16_bold(fg31_red)},
    char: {:self=>ansi16(fg35_magenta), :delimiter=>ansi16_bold(fg35_magenta)},
    class: ansi16_bold_underlined(fg35_magenta),
    class_variable: ansi16(fg36_cyan),
    color: ansi16(fg32_green),
    comment: ansi256_fg(123) + ansi256_bg(23),
    # constant: ansi16_bold_underlined(fg34_blue),
    constant: ansi16_bold_underlined(fg94_blue),
    decorator: ansi16(fg35_magenta),
    definition: ansi256_fg(170),
    directive:ansi16(bg43_yellow),
    docstring: ansi16(fg31_red),
    # doctype: ansi16_bold(fg34_blue),
    doctype: ansi16_bold(fg94_blue),
    done: ansi16_bold_dull(fg30_black),
    entity: ansi16(fg31_red),
    error: ansi16_bold(fg37_white, bg41_red),
    exception: ansi16_bold(fg31_red),
    float: ansi16_bold(fg35_magenta),
    # function: ansi16_bold(fg34_blue),
    function: ansi16_bold(fg94_blue),
    global_variable: ansi16_bold(fg32_green),
    hex: ansi16_bold(fg36_cyan),
    # id: ansi16_bold(fg34_blue),
    id: ansi16_bold(fg94_blue),
    include: ansi16(fg31_red),
    integer: ansi256_fg(168),
    # imaginary: ansi16_bold(fg34_blue),
    imaginary: ansi16_bold(fg94_blue),
    important: ansi16_bold(fg31_red),
    key: {:self=>ansi16(fg35_magenta), :char=>ansi16_bold(fg35_magenta), :delimiter=>ansi16_bold(fg35_magenta)},
    keyword: ansi16(fg32_green),
    label: ansi16_bold(fg33_yellow),
    local_variable:ansi16(bg43_yellow),
    namespace: ansi16_bold(fg35_magenta),
    # octal: ansi16_bold(fg34_blue),
    octal: ansi16_bold(fg94_blue),
    predefined: ansi16(fg36_cyan),
    predefined_constant: ansi16_bold(fg36_cyan),
    predefined_type: ansi16_bold(fg32_green),
    preprocessor: ansi16_bold(fg36_cyan),
    # pseudo_class: ansi16_bold(fg34_blue),
    pseudo_class: ansi16_bold(fg94_blue),
    regexp: {:self=>ansi16(fg35_magenta), :delimiter=>ansi16_bold(fg35_magenta), :modifier=>ansi16(fg35_magenta), :char=>ansi16_bold(fg35_magenta)},
    reserved: ansi16(fg32_green),
    shell: {:self=>ansi16(fg33_yellow), :char=>ansi16_bold(fg33_yellow), :delimiter=>ansi16_bold(fg33_yellow), :escape=>ansi16_bold(fg33_yellow)},
    string: {:self=>ansi16(fg31_red), :modifier=>ansi16_bold(fg31_red), :char=>ansi16_bold(fg35_magenta), :delimiter=>ansi16_bold(fg31_red), :escape=>ansi16_bold(fg31_red)},
    symbol: ansi256_fg(196) + ansi256_bg(52),
    tag: ansi16(fg32_green),
    type: ansi256_fg(48) + ansi256_bg(18),
    value: ansi16(fg36_cyan),
    # variable: ansi16(fg34_blue),
    variable: ansi16(fg94_blue),
    insert: {:self=>ansi16(bg42_green), :insert=> ansi16_bold(fg32_green, bg42_green), :eyecatcher=>ansi16(bg102_green)},
    delete: {:self=>ansi16(bg41_red), :delete=>ansi16_bold(fg31_red, bg41_red), :eyecatcher=>ansi16(bg101_red)},
    change: {:self=>ansi16(bg44_blue), :change=> ansi16(fg37_white, bg44_blue)},
    head: {:self=>ansi16(bg45_magenta), :filename=>ansi16(fg37_white, bg45_magenta)},
    method: ansi256_fg(14),
    escape: nil,
  }.each do |k, v|
    CodeRay::Encoders::Terminal::TOKEN_COLORS[k] = v
  end
  hacked = CodeRay::Encoders::Terminal::TOKEN_COLORS.dup

  # NOTE: オリジナルとの違いがどこにあるか、確認したいですか？
  # (hacked.to_a - original.to_a).each { |k,v| print("#{k} = #{v}aaaa" + reset + "\n") }

  # 表示されるコード範囲を広くする
  Pry.config.window_size = 20

  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 'ss', 'show-source'
end

