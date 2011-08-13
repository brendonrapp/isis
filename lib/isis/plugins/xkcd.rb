require 'isis/plugins/base'
require 'nokogiri'
require 'open-uri'

class Isis::Plugin::XKCD < Isis::Plugin::Base

  def respond_to_msg?(msg)
    @commands = msg.split
    @commands[0] == "!xkcd" ? true : false
  end

  def response

    if @commands[1].nil?
      new_comic and return
    end

    case @commands[1].downcase
    when "random"
      random_comic  
    when "new"
      new_comic
    else 
      "I have no idea what #{@commands[1]} means. No comic for you"
    end
  end

  def new_comic
    page = Nokogiri::HTML(open('http://xkcd.com/'))
    image = page.css('.s > img').first
    [image['src'], image['title']]
  end

  def random_comic
    page = Nokogiri::HTML(open('http://dynamic.xkcd.com/random/comic/'))
    image = page.css('.s > img').first
    [image['src'], image['title']]
  end
end
