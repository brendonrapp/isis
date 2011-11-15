require 'isis/plugins/base'
require 'nokogiri'
require 'open-uri'

class Isis::Plugin::FML < Isis::Plugin::Base

  def respond_to_msg?(msg, speaker)
    /\b[!]?fml\b/i =~ msg ? true : false
  end

  def response
    page = Nokogiri::HTML(open("http://www.fmylife.com/random"))
    selected = rand(page.css('.article > p').length)
    fml = page.css('.article > p')[selected].text
    link = page.css('.article > p')[selected].css('a').first['href']
    number = page.css('.article')[seleted].css('.date .left_part a').text
    "FML #{number}: \"#{fml}\" (link: http://fmylife.com#{link})"
  end
end
