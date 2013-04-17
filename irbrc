# Activate auto-completion.
require 'irb/completion'
require 'pp'

# History
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE]  = :SIMPLE

# Add current dir to load path
$LOAD_PATH << '.'

# A few nice bits on Object
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end