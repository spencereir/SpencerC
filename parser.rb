require_relative 'command.rb'
require './exception'
require 'colored'
require 'win32console'

class Parser
  @@vars = {"default" => 3}
  @text = ""
  @numParts = 0
  @parts = []
  def initialize(text, lineNum)
    @text = text
    @lineNum = lineNum
    @parts = @text.split(" ")
    @numParts = @parts.length
  end
  def parse() 
    if(/^#{$commands['variableDeclaration']}/.match(@parts[0]))
      if(@numParts > 2)
        eq_parts = @text.split(" ")
        eq_parts.shift(3)
        equation = eq_parts.join
        eq_parts.each do |i|
          if(/[a-zA-Z]+/.match(i))
            if(@@vars.has_key?(i))
              equation.gsub!(i, "@@vars['#{i}']")
            else
              e = Exception.new(1, i, @lineNum)
            end  
          end
        end        
        case @parts[2]
        when '='
          @@vars.store(@parts[1], eval(equation)) 
        when '+='
          @@vars.store(@parts[1], @parts[1] + eval(equation))
        end
      else
        @@vars.store(@parts[1], 0)
      end
    
    elsif(/^#{$commands['print']}/.match(@parts[0]))
      if(/^\"/.match(@parts[1]))
        if(/\"$/.match(@parts[@parts.length - 1]))
          @print_var = @text.split(" ")
          @print_var.shift(1)
          (@print_var.length - 1).times do |i|
            @print_var[i] += " "
          end
          @print_var_flat = @print_var.join
          @print_var_flat.gsub!('"', '')
          puts @print_var_flat
        else
          e = Exception.new(3, "\"", @lineNum)
        end
      else
        if(@parts.length < 3)
          if(@@vars.has_key?(@parts[1]))
            puts @@vars[@parts[1]]
          else
            e = Exception.new(1, @parts[1], @lineNum)
          end
        else
          puts @@vars[@parts[1]]
          puts "Warn: You can only print 1 variable at a time. Other variables will be ignored.\nAdd @supress at the top of your program to disable warnings.".yellow
        end  
      end  
    
    elsif(/^#{$commands['input']}/.match(@parts[0]))
      input = STDIN.gets
      input = input.chomp
      if(@@vars.has_key?(@parts[1]))
        @@vars.store(@parts[1], input)
      else
        e = Exception.new(1, @parts[1], @lineNum)
      end      
    else
      if(@@vars.has_key?(@parts[0]))
        if(@numParts > 1) 
          eq_parts = @text.split(" ")
          eq_parts.shift(2)
          equation = eq_parts.join
          eq_parts.each do |i|
            if(/[a-zA-Z]+/.match(i))
              if(@@vars.has_key?(i))
                equation.gsub!(i, "@@vars['#{i}']")
              else
                e = Exception.new(1, i, @lineNum)
              end  
            end
          end        
          case @parts[1]
          when '='
            ans = eval(equation)
            @@vars.store(@parts[0], ans) 
          when '+='
            ans = eval(equation)
            ans += @@vars[@parts[0]].to_i
            @@vars.store(@parts[0], ans)
          when '-='
            ans = eval(equation)
            ans -= @@vars[@parts[0]].to_i
            @@vars.store(@parts[0], ans)
          when '*='
            ans = eval(equation)
            ans *= @@vars[@parts[0]].to_i
            @@vars.store(@parts[0], ans)
          when '/='
            ans = eval(equation)
            ans /= @@vars[@parts[0]].to_i
            @@vars.store(@parts[0], ans)
          end
        else
          e = Exception.new(5, @parts[0], @lineNum)
        end
      end
    end
  end
end