# HipChat connection
# Uses HipChat's XMPP connection

require 'xmpp4r'
require 'xmpp4r/muc/helper/simplemucclient'
require 'isis/connections/base'

class Isis::Connections::HipChat < Isis::Connections::Base

  attr_accessor :client
  attr_accessor :muc

  def initialize(config)
    load_config(config)
    @client = Jabber::Client.new(@config['hipchat']['jid'])

    @muc = {}
    @config['hipchat']['rooms'].each do |room|
      @muc[room] = Jabber::MUC::SimpleMUCClient.new(client)
    end
  end

  def send_jabber_presence
    @client.send(Jabber::Presence.new.set_type(:available))
  end

  def connect
    @client.connect
    @client.auth(@config['hipchat']['password'])
    send_jabber_presence
    @join_time = Time.now
  end

  def register_disconnect_callback
    @client.on_exception do |e, stream, where|
      puts "Exception! #{e.to_s}"
      self.connect  # Reconnect!
    end
  end

  def register_plugins(bot)
    @muc.each do |room,muc|
      register_plugins_internal(muc, bot)
    end
  end

  def register_plugins_internal(muc, bot)
    muc.on_message do |time, speaker, message|
      # |time| is useless - comes back blank
      # we must fend for ourselves

      # always respond to commands prefixed with 'sudo '
      sudo = message.match /^sudo (.+)/
      message = sudo[1] if sudo

      # ignore our own messages
      if speaker == @config['hipchat']['name'] and not sudo
        nil

      else
        bot.plugins.each do |plugin|
          begin
            response = plugin.receive_message(message, speaker)
            unless response.nil?
              if response.respond_to?('each')
                response.each {|line| speak(muc, line)}
              else
                speak(muc, response)
              end
            end
          rescue => e
            speak muc, "ERROR: Plugin #{plugin.class.name} just crashed"
            speak muc, "Message: #{e.message}"
          end
        end
      end
    end

    muc.on_private_message do |time, speaker, message|
      nil
    end

    muc.on_room_message do |time, message|
      nil
    end
  end

  def join
    @muc.each do |room,muc|
      muc.join "#{room}/#{@config['hipchat']['name']}", @config['hipchat']['password'], :history => @config['hipchat']['history']
    end
  end

  def yell(message)
    @muc.each do |room,muc|
      muc.send Jabber::Message.new(muc.room, message)
    end
  end

  def speak(muc, message)
    muc.send Jabber::Message.new(muc.room, message)
  end

  def still_connected?
    @client.is_connected?
  end
end
