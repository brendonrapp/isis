#!/usr/bin/env ruby

require 'yaml'
require 'singleton'
require 'isis/plugins'
require 'isis/connections'

module Isis
  class Chatbot

    attr_accessor :config, :connection, :plugins

    def initialize
      @config = YAML::load(File.read(File.join(ROOT_FOLDER, 'config.yml')))
      load_plugins
      if @config['service'] == 'hipchat'
        @connection = Isis::Connections::HipChat.new(config)
      elsif @config['service'] == 'campfire'
        @connection = Isis::Connections::Campfire.new(config)
      else
        puts "Invalid service selected - please check your config.yml"
      end
    end

    def load_plugins
      self.plugins = []
      class_prefix = "Isis::Plugin::"

      @config['enabled_plugins'].each do |plugin|
        self.plugins << eval(class_prefix + plugin).new
      end
    end

    def connect
      @connection.connect
    end

    def join
      @connection.join
    end

    def speak(message)
      @connection.speak message
    end

    def register_plugins
      @connection.register_plugins(self)
    end

    def still_connected?
      @connection.still_connected?
    end

    def trap_signals
      [:INT, :TERM].each do |sig|
        trap(sig) do
          puts "Trapped signal #{sig.to_s}"
          puts "Shutting down gracefully"
          self.speak @config['bot']['goodbye']
          exit
        end
      end
    end

    def run
      connect
      trap_signals
      register_plugins
      join

      i = 0

      loop do
        sleep 1
        i += 1
        
        # am I still connected, bro? Check only every 10 seconds
        if i >= 10
          i = 0
          unless still_connected?
            puts "Disconnected! Reconnecting..."
            connect
            trap_signals
            register_plugins
            join
          end
        end
      end
    end
  end
end
