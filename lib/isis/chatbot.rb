# chatbot.rb

require 'singleton'

module Isis
  class Chatbot
    include Singleton

    @@enabled_plugins = {}
    @@command_listeners = {}
    @@message_listeners = {}
    @@enter_listeners = {}
    @@join_listeners = {}

    def initialize
      @config = YAML::Load(File.read(File.join(ROOT_FOLDER, 'config.yml')))
      @chat = Tinder::Campfire.new @config[:subdomain], :token => @config[:api_key]
    end

    def run
      join_room
      @room.listen do |m|
        # Listen and process crap
      end
    end

    def join_room
      @room = @chat.find_room_by_name(@config[:room])
      raise Exception.new("Could not find room named: ${@config[:room]}") if @room.nil?
      @room.join
    end

    def load_plugins
      @config[:enabled_plugins].each do |p|
        @@enabled_plugins.push p
        p.register_plugin
      end
    end

    def speak(message)
      @room.speak message
    end

    def paste(message)
      @room.paste message
    end
  end
end
