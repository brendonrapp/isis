# Campfire connection

require 'tinder'
require 'isis/connections/base'

class Isis::Connections::Campfire < Isis::Connections::Base

  attr_accessor :client

  def initialize(config)
    load_config(config)
    if config['campfire']['auth_mode'] == 'api'
      @client = Tinder::Campfire.new config['campfire']['subdomain'], :token => config['campfire']['api_key']
    elsif config['campfire']['auth_mode'] == 'username'
      @client = Tinder::Campfire.new config['campfire']['subdomain'], :username => config['campfire']['username'], :password => config['campfire']['password']
    else
      puts "Invalid authentication mode set - please check auth_mode settings in config.yml"
      exit
    end
  end

  def connect
    @join_time = Time.now
  end

  def register_disconnect_callback
    nil
  end

  def register_plugins(bot)
    # Tinder's EventMachine loop provides message info in a hash
    @room.listen do |message|
      bot.plugins.each do |plugin|
        begin
          response = plugin.receive_message(message[:body], message[:user][:name])
          unless response.nil?
            # if response is a collection, loop through, one per line
            if response.respond_to?('each')
              response.each do |line|
                self.speak line
              end
            else
              self.speak response
            end
          end
        rescue => e
          self.speak "ERROR: Plugin #{plugin.class.name} just crashed"
          self.speak "Message: #{e.message}"
        end
      end
    end
  end

  def join
    @room = @client.find_room_by_name(@config['campfire']['room'])
    @room.join
  end

  def speak(message)
    @room.speak message
  end

  def still_connected?
    # TODO: Check that connection is still live - returning TRUE for now
    true
  end
end
