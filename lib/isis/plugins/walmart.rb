require 'isis/plugins/base'
require 'nokogiri'
require 'open-uri'

class Isis::Plugin::WalMart < Isis::Plugin::Base

  def respond_to_msg?(msg, speaker)
    /wal[-\*]?mart/i =~ msg
  end

  def response
    page_number = rand(780)
    page = Nokogiri::HTML(open("http://www.peopleofwalmart.com/photos/random-photos/page/#{page_number}"))
    selected = rand((page.css('.page h2+p img').length)-1)
    image = page.css('.page h2+p img')[selected]
    title = page.css('.page h2')[selected]
    ["PEOPLE OF WAL-MART:", image['src'], title.text]
  end
end
