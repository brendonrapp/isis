require 'isis/plugins/base'
require 'nokogiri'
require 'open-uri'

class Isis::Plugin::WalMart < Isis::Plugin::Base

  def respond_to_msg?(msg, speaker)
    /wal[-\*]?mart/i =~ msg ? true : false
  end

  def response
    r = Random.new
    page_number = r.rand(1..780)
    page = Nokogiri::HTML(open("http://www.peopleofwalmart.com/photos/random-photos/page/#{page_number}"))
    selected = r.rand(0..(page.css('.page h2+p img').length)-1)
    image = page.css('.page h2+p img')[selected]
    title = page.css('.page h2')[selected]
    [image['src'], title.text]
  end
end
