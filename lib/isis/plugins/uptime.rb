require 'isis/plugins/base'

class Isis::Plugin::Uptime < Isis::Plugin::Base
  def initialize
    @boot = Time.now
    puts "Uptime-boot #{@boot}"
  end

  def respond_to_msg?(msg, speaker)
    /[\b]?!uptime\b/i =~ msg
  end

  def response
    "Up #{Time.now - @boot} seconds. Since #{@boot}."
  end
end
