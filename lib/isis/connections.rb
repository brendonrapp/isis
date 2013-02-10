# Include all files in plugins/ dir

# Dir[File.dirname(__FILE__) + '/connections/*'].each { |file| require file }

require 'isis/connections/base'
require 'isis/connections/campfire'
require 'isis/connections/hipchat-jruby' if RUBY_PLATFORM == "java"
require 'isis/connections/hipchat' if RUBY_PLATFORM == "ruby"
