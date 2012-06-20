# encoding: UTF-8

lib_dir = File.expand_path(File.join(File.dirname(__FILE__), "../lib"))

if File.exist?(File.join(lib_dir, "isis.rb"))
  $LOAD_PATH.unshift lib_dir
end

require 'isis'
require 'isis/chatbot'

EM.run do
  @bot = Isis::Chatbot.new

  # Tramps like us, baby we were born to...
  @bot.run
end
