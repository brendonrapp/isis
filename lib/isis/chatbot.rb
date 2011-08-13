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
      @connection = Isis::Connections::HipChat.new(config)
    end

    def load_plugins
      self.plugins = []
      class_prefix = "Isis::Plugin::"

      @config['enabled_plugins'].each do |plugin|
        self.plugins << eval(class_prefix + plugin).new
      end

      puts self.plugins.to_s
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

    def trap_signals
      [:INT, :TERM].each do |sig|
        trap(sig) do
          puts "Trapped signal #{sig.to_s}"
          puts "Shutting down gracefully"
          self.speak "Home sweet hooome!"
          exit
        end
      end
    end

    def run
      connect
      trap_signals
      register_plugins
      join
    end
  end
end
