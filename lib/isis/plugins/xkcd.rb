require 'isis/plugins/base'
require 'nokogiri'
require 'open-uri'

class Isis::Plugin::XKCD < Isis::Plugin::Base

  def respond_to_msg?(msg, speaker)
    @commands = msg.split
    @commands[0] == "!xkcd" ? true : false
  end

  def response
    if @commands[1].nil?
      return new_comic
    end

    if @commands[1].is_a? Integer
      return selected_comic(@commands[1])
    end

    case @commands[1].downcase
    when "random"
      random_comic
    when "new"
      new_comic
    when "commands"
      "Understood command arguments for !xkcd: new, random, (number-of-comic)"
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

  # TODO: handle 404 on invalid comic number
  def selected_comic(number)
    page = Nokogiri::HTML(open("http://xkcd.com/#{number}/"))
    image = page.css('.s > img').first
    [image['src'], image['title']]
  end

end
