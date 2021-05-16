if defined?(PryByebug)
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
end

