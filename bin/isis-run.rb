# encoding: UTF-8

$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__)), "../lib")) unless $LOAD_PATH.include?(File.expand_path(File.join(File.dirname(__FILE__)), "../lib"))

require 'isis'
require 'isis/chatbot'

@bot = Isis::Chatbot.new

# Tramps like us, baby we were born to...
@bot.run

