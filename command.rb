$commands = {
  "variableDeclaration" => "dec",
  "print" => "LOUDLYWHISPER",
  "input" => "INPUTAVARIABLEPLS"
}

$command_help = {
  "#{$commands['variableDeclaration']}" => "Used to declare a variable.\nSyntax: #{$commands['variableDeclaration']} (variable name) = (value)",
  "#{$commands['print']}" => "Used to print text to the screen.\nSyntax: #{$commands['print']} \"text to print\"\n    or: #{$commands['print']} (variable name)",
  "#{$commands['input']}" => "Used to get user input.\nSyntax: #{$commands['print']} (variable to store data in)"
}

class Command
  @function = ""
  @command = ""
  def initialize(function, command)
    @function = function
    @command = command
  end
  def dict()
    puts $commands
  end  
end