# HipChat-JRuby connection
# Uses HipChat's XMPP connection
# Also uses HipChat API for HTML sending

require 'smackr'
require 'hipchat-api'
require 'isis/connections/base'
require 'em-timers'

class Isis::Connections::HipChatJRuby < Isis::Connections::Base

  attr_accessor :client
  attr_accessor :rooms
  attr_accessor :bot

  def initialize(config)
    load_config(config)
    create_jabber
  end

  def create_jabber
    # Smackr doesn't take full JID, parse into parts
    username, server = @config['hipchat']['jid'].split("@")
    password = @config['hipchat']['password']
    @client = Smackr.new(:server => server, :username => username, :password => password, :resource => 'bot')
  end

  def connect
    @client.connect!
    @join_time = Time.now
  end

  def join_rooms
    @rooms = []
    @config['hipchat']['rooms'].each do |roomname|
      room = @client.join_room(roomname, :nickname => @config['hipchat']['name'])
      room.message_callback = self.method(:message_response_callback)
      room.participant_callback = self.method(:participant_callback)
      room.joined_callback = self.method(:joined_callback)
      room.left_callback = self.method(:left_callback)
      @rooms << room
    end
    puts "Room last: #{@rooms.last}"
  end

  def reconnect
    kill_and_clean_up
    create_jabber
    connect
  end

  def kill_and_clean_up
    @client.close
  end

  def register_disconnect_callback
    @client.on_exception do |e, stream, where|
      puts "Exception! #{e.to_s}"
      self.connect  # Reconnect!
    end
  end

  def register_plugins(bot)
    @bot = bot
    # puts "DEBUG: bot.hello_messages not empty!" unless bot.hello_messages.empty?
    @bot.hello_messages = []
    @bot.plugins.each do |plugin|
      @bot.hello_messages.push plugin.hello_message if plugin.hello_message
    end
  end

  def message_response_callback(packet, room)
    speaker = parse_name(packet.from)
    message = packet.body

    puts "MESSAGE: s:#{speaker} m:#{message}"
    # ignore our own messages
    if speaker == @config['hipchat']['name']
      nil

    else
      @bot.plugins.each do |plugin|
        begin
          response = plugin.receive_message(message, speaker)
          unless response.nil?
            if response.respond_to?('each')
              response.each {|line| speak(room, line)}
            else
              speak(room, response)
            end
          end
        rescue => e
          speak room, "ERROR: Plugin #{plugin.class.name} just crashed"
          speak room, "Message: #{e.message}"
        end
      end
    end
  end

  def participant_callback(packet, room)
    nil
  end

  def joined_callback(name, room)
    @bot.plugins.each do |plugin|
      begin
        speak room, plugin.joined(name) if plugin.respond_to?('joined')
      end
    end
  end

  def left_callback(name, room)
    @bot.plugins.each do |plugin|
      begin
        speak room, plugin.left(name) if plugin.respond_to?('left')
      end
    end
  end

  def timer_response
    nil
  end

  def join
    join_rooms
  end

  def yell(message)
    @rooms.each do |room|
      room.send_message message
    end
  end

  def speak(room, message)
    room.send_message message
  end

  def still_connected?
    @client.xmpp_connection and @client.xmpp_connection.is_connected
  end

  private
  def parse_name(name)
    name.split("/")[1]
  end
end
