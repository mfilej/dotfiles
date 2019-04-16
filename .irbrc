def enable_irb_history(filename)
  require "irb/ext/save-history"
  IRB.conf[:SAVE_HISTORY] = 1000
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.#{filename}"
end

if Object.const_defined? :RUBY_ENGINE
  case RUBY_ENGINE
  when "ruby"
    enable_irb_history "irb-history"
  when "jruby"
    enable_irb_history "irb-jruby-history"
  end
end
