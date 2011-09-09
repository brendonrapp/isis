require 'isis/plugins/base'
require 'nokogiri'
require 'open-uri'

class Isis::Plugin::QuickMeme < Isis::Plugin::Base

  def respond_to_msg?(msg, speaker)
    @commands = msg.split
    @commands[0] == "!qm" || "!quickmeme" ? true : false
  end

  def response
    grab_image(@commands[1])
  end

  def grab_image(from)
    case from.downcase
    when random
      page = Nokogiri::HTML(open('http://www.quickmeme.com/random/'))
    when popular
      page = Nokogiri::HTML(open('http://www.quickmeme.com/popular/'))
    else
      page = Nokogiri::HTML(open('http://www.quickmeme.com'))
    end

    images = page.css('.memeThumb > a > img').all
    image = images[rand(images.length)]
    image['src']
  end
end
