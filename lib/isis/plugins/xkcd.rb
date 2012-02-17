require 'isis/plugins/base'
require 'nokogiri'
require 'open-uri'
require 'sequel'

class Isis::Plugin::XKCD < Isis::Plugin::Base
  def initialize
    # Setup Comic Archive
    @dbready = false
    load_archive
  end

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

private
  def load_comic(url)
      page = Nokogiri::HTML(open(url))
      if(match = /(\d+)/.match(page.at('#middleContent .s h3').inner_html))
        @last_comic = match.captures.first.to_i

        image = page.at('#middleContent .s img')
        ["broken"+image['src'], image['title']]
      else
        "404??"
    end
  end

  def load_archive
    # connect to an in-memory database
    @db = Sequel.sqlite

    # create an items table
    @db.create_table :comics do
      primary_key :id
      String :name
      String :date
    end

    # create a dataset from the items table
    comics = @db[:comics]
      id_parse = /(\d+)/ # ID parsing regexp
      archive = Nokogiri::HTML(open('http://xkcd.com/archive/'))

      archive.css('.s > a').each do |data|
        if(match = id_parse.match(data[:href]))
          comic_id = match.captures.first

          # puts "#{comic_id} #{data.inner_html} #{data[:title]}\n"
          comics.insert(:id => comic_id, :name => data.inner_html, :date => data[:title])
        end
      end
      @last_comic = comics.max(:id)
      @dbready = true

      # print out the number of records
      puts "xkcd: Loaded #{comics.count} comics"
  end

end
