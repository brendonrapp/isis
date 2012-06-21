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
      @connection = case @config['service']
      when 'hipchat'
        Isis::Connections::HipChat.new(config)
      when 'campfire'
        Isis::Connections::Campfire.new(config)
      else
        raise "Invalid service selected - please check your config.yml"
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
      EventMachine::Timer.new(1) { speak @config['bot']['hello'] }
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
          speak @config['bot']['goodbye']
          EventMachine::Timer.new(1) { EventMachine::stop_event_loop }
        end
      end
    end

    def run
      connect
      trap_signals
      register_plugins
      join

      # am I still connected, bro? Check every 10 seconds
      EventMachine::add_periodic_timer(10) {
        unless still_connected?
          puts "Disconnected! Reconnecting..."
          connect
          trap_signals
          register_plugins
          join
        end
      }
    end

  end
end
