# plugin.rb

module Isis
  class Plugin

    def initialize
      @bot = Isis::Chatbot.instance
    end

    def register_plugin
    
    end

    def speak(message)
      @bot.speak message
    end

  end
end
