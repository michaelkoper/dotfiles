#!/usr/bin/ruby
require 'irb/completion'
# require 'irb/ext/save-history'

MY_EMAIL_ADDRESS = 'hello@michaelkoper.com'
IRB.conf[:SAVE_HISTORY] = 10000000
# IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
#
# IRB.conf[:PROMPT_MODE] = :SIMPLE
#
# IRB.conf[:AUTO_INDENT] = true

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end

  def find_me
    User.find_by_email MY_EMAIL_ADDRESS
  end
end

if defined? Rails
  banner = if Rails.env.production?
    "\e[41;97;1m #{ Rails.env } \e[0m "
  else
    "\e[42;97;1m #{ Rails.env } \e[0m "
  end

  # Build a custom prompt
  IRB.conf[:PROMPT][:CUSTOM] = IRB.conf[:PROMPT][:DEFAULT].merge(
    PROMPT_I: banner + IRB.conf[:PROMPT][:DEFAULT][:PROMPT_I],
  )

  # Use custom prompt by default
  IRB.conf[:PROMPT_MODE] = :CUSTOM
end
