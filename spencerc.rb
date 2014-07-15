require_relative 'command.rb'
require 'colored'
require 'win32console'
require './parser'
require './time'
require './exception'

$filetype = ".spencerc"
t = Time.now

c = []
$commands.each do |key, value|
  c << Command.new(key, value)
end

def help() 
  puts "    SpencerC v1.1 Commands:\n
        -h                              Shows the help dialog
        -h (command)                    Help for a specific command
        list                            Shows all commands
        *#{$filetype}                      Run a #{$filetype} file"
end

case ARGV.length
when 0
  puts "Use spencerC -h for a list of all commands"
when 1
  if(ARGV[0].eql? "-h") 
    help() 
  end
  if(ARGV[0].eql? "list")
    puts $commands          #TODO: Work on this one. Srsly
  end
  if(/.spencerc$/.match(ARGV[0]))
    if(File.exists?(ARGV[0]))
      f = File.new(ARGV[0], "r")
      lines = []
      while(line = f.gets)
        lines << line
      end
      p = []
      lines.length.times do |i|
        p[i] = Parser.new(lines[i], i)
      end
      p.each do |parser|
        parser.parse()
      end
    end
  end
when 2
  if(ARGV[0].eql? "-h")
    if($commands.key(ARGV[1]) != nil)
      puts $command_help[$commands[$commands.key(ARGV[1])]]
    else
      e = Exception.new(4, ARGV[1], 0)
    end
  end
when 3
end


