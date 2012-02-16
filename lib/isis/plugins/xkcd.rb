require 'isis/plugins/base'
require 'nokogiri'
require 'open-uri'

class Isis::Plugin::XKCD < Isis::Plugin::Base

  def respond_to_msg?(msg, speaker)
    @commands = msg.downcase.split
    @commands[0] == "!xkcd"
  end

  def response
    verb = @commands[1]

    return case
    when verb.nil?
      new_comic
    when verb.to_i.to_s == verb
      selected_comic(verb)
    when verb == "random"
      random_comic
    when verb == "new"
      new_comic
    when (verb == "commands" or verb == "help")
      "Understood command arguments for !xkcd: new, random, (number-of-comic)"
    else
      "I have no idea what #{verb} means. No comic for you."
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
