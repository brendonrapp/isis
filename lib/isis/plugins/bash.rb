require 'isis/plugins/base'
require 'nokogiri'
require 'open-uri'

class Isis::Plugin::Bash < Isis::Plugin::Base

  def respond_to_msg?(msg, speaker)
    /\b[!]?bash\b/i =~ msg ? true : false
  end

  def response
    page = Nokogiri::HTML(open("http://bash.org?random1"))
    selected = rand(page.css('.quote').length)
    link = page.css('.quote')[selected].css('a').first['href']
    quote = page.css('.qt')[selected].text
    number = link.gsub('?', '')
    "bash.org ##{number}: \"#{quote}\" (link: http://bash.org#{link})"
  end
end
