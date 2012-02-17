require 'isis/plugins/base'
require 'nokogiri'
require 'open-uri'
require 'sequel'
require 'eventmachine'

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
    when !@dbready
      ["Hold up, I'm not ready yet."]

    when (!defined?(verb) or verb.blank? or verb == "random")
      load_comic 'http://dynamic.xkcd.com/random/comic/'

    when (verb == "new" or verb == "last")
      load_comic 'http://xkcd.com/'

    when verb.to_i.to_s == verb # When integer
      selected_comic(verb.to_i)

    when verb == "first"
      selected_comic 1

    when verb == "next"
      @last_comic += 1
      selected_comic(@last_comic)

    when verb == "prev"
      @last_comic -= 1
      selected_comic(@last_comic)

    when verb == "date"
      @db[:comics].where(:id => @last_comic).select(:date).first[:date]

    when verb == "number"
      @last_comic.to_s

    when verb == "d"
      "COMIC index: #{@last_comic}, count: #{@db[:comics].count}, max: #{@db[:comics].max(:id)}, min: #{@db[:comics].min(:id)}"

    when (verb == "commands" or verb == "help" or verb == "--help" or verb == "-h")
      "Understood command arguments for !xkcd:\n"+
      "\tnew, last: current comic\n"+
      "\trandom: ??\n"+
      "\t(number-of-comic), 1, 314: display comic by number\n"+
      "\tfirst: comic #1\n"+
      "\tnext, prev: browse through comics\n"+
      "\tdate: get date of last comic\n"+
      "\tnumber: get number of last comic"

    else
      "I have no idea what #{verb} means. Please come again."

    end
  end


  def selected_comic(number)
    case
    when(number <= @db[:comics].max(:id) and number >= @db[:comics].min(:id))
      # @last_comic = number
      load_comic "http://xkcd.com/#{number}/"

    when number < 0
      ["negative comic number? really?"]

    when number == 0
      ["THERE IS NO COMIC ZERO"]

    else # number > comic.max
      ["xkcd has produced #{@db[:comics].max(:id)} comics. try one of those."]

    end
  end

private
  def load_comic(url)
      page = Nokogiri::HTML(open(url))
      if(match = /(\d+)/.match(page.at('#middleContent .s h3').inner_html))
        @last_comic = match.captures.first.to_i

        image = page.at('#middleContent .s img')
        [image['src'], image['title']]
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

    EM.next_tick do
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
    end # end EM

  end

end
