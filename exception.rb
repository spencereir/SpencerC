require 'colored'
require 'win32console'

class Exception
  def initialize(errCode, info, lineNum)
    self.throw(errCode, info, lineNum)
  end
  def throw(errCode, info, lineNum)
    lineNum += 1
    case errCode
    when 0                    # No such file exception
      puts "\n\n[ERROR] Process exited with error code 0: #{info}: No such file or directory".red
    when 1                    # Undeclared variable exception
      puts "\n\n[ERROR] Process exited with error code 1: Line #{lineNum}: Variable #{info} not declared".red
    when 2                    # Failed to excecute exception
      puts "\n\n[ERROR] Process exited with error code 2: Installation of #{info} failed".red
    when 3                    # Unclosed token exception
      puts "\n\n[ERROR] Process exited with error code 3: Line #{lineNum}: Unclosed token #{info}".red
    when 4                    # Unrecognized command exception
      puts "\n\n[ERROR] Process exited with error code 4: Unrecognized command #{info}".red
    when 5
      puts "\n\n[ERRPR] Process exited with error code 5: Line #{lineNum}: #{info} cannot be used as a statement".red
    end
    exit!
  end
end