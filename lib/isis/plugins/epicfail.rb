# epicfail.rb
# Random post from epicfail.com

require 'isis/plugins/base'
require 'nokogiri'
require 'open-uri'

class Isis::Plugin::EpicFail < Isis::Plugin::Base

  def respond_to_msg?(msg, speaker)
    /\bfail\b/i =~ msg ? true : false
  end

  def response
    page_number = rand(330)
    page = Nokogiri::HTML(open("http://www.epicfail.com/type.php?fail=picture&page=#{page_number}"))
    selected = rand(page.css('.post').length)
    image = page.css('.post .entry a img')[selected]
    title = page.css('.post .hed h2 a')[selected]
    [image['src'], title.text]
  end

end
