require 'isis/plugins/base'
require 'nokogiri'
require 'open-uri'

class Isis::Plugin::PennyArcade < Isis::Plugin::Base

  def respond_to_msg?(msg)
    msg.downcase == "!pa" ? true : false
  end

  def response
    comic
  end

  def comic
    page = Nokogiri::HTML(open('http://penny-arcade.com/comic/'))
    image = page.css('.body > img').first
    [image['src'], image['alt']]
  end
end
