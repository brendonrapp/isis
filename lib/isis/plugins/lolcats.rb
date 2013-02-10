# lolcats.rb
# Random lolcat from icanhas.cheezburger.com

# require 'isis/plugins/base'
require 'nokogiri'
require 'open-uri'

class Isis::Plugin::LOLCats < Isis::Plugin::Base
  def respond_to_msg?(msg, speaker)
    /\blolcat\b/i =~ msg
  end

  def response
    page_number = rand(2..409)
    page = Nokogiri::HTML(open("http://icanhas.cheezburger.com/lolcats/page/#{page_number}"))
    selected = rand(page.css('.event-item-lol-image').length)
    image = page.css('.event-item-lol-image')[selected]
    "#{image['src'][0..-2]}.jpg"
  end
end
