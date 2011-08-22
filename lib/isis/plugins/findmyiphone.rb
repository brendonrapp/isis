require 'isis/plugins/base'
require 'nokogiri'
require 'open-uri'

class Isis::Plugin::FindMyIphone < Isis::Plugin::Base

  def respond_to_msg?(msg, speaker)
    msg.downcase == "!findmyiphone" ? true : false
  end

  def response
    "It's probably in your pocket"
  end
end
