require 'isis/plugins/base'
require 'nokogiri'
require 'open-uri'
require 'eventmachine'
require 'amatch'

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
      @comic_dates[ @last_comic ]

    when verb == "number"
      @last_comic.to_s

    when verb == "reload"
      load_archive

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
      result = find_comic @commands[1,100].join(" ")
      if result.is_a?(Integer)
        selected_comic result
      elsif result.is_a?(NilClass)
        "No Comics found"
      else
        result.collect {|r,id| "#{"%.2f"% (r*100)}% ##{id} \"#{@comic_titles[id]}\""}
      end

    end
  end

  def selected_comic(number)
    case
    when(number <= @comic_count and number > 0)
      # @comic_count = number
      load_comic "http://xkcd.com/#{number}/"

    when number < 0
      ["negative comic number? really?"]

    when number == 0
      ["THERE IS NO COMIC ZERO"]

    else # number > comic.max
      ["xkcd has produced #{@comic_count} comics. try one of those."]

    end
  end

private
  def load_comic(url)
      page = Nokogiri::HTML(open(url))
      if(match = /Permanent link to this comic: http:\/\/xkcd\.com\/(\d+)\//.match(page.css('#middleContainer').inner_html))
        @last_comic = match.captures.first.to_i

        image = page.at('#comic img')
        [ "##{@last_comic} \"#{@comic_titles[@last_comic]}\" (#{@comic_dates[@last_comic]}) #{image['src']}", image['title'] ]
      else
        "404??"
    end
  end

  def find_comic(str)
    jarow = Amatch::JaroWinkler.new( str )

    possible = {}
    @comic_titles.each do |id,title|
      rating = jarow.match title

      if rating > 0.6
        # puts "#{rating} - #{title} ##{id}"
        possible.merge! rating => id
      end

    end
    return nil if possible.empty?

    # Heighest 5 rating comics
    possible = possible.sort[-5,5].reverse

    if possible.first.first > 0.85
      possible.first.last
    else
      possible
    end
  end
  # r = find_comic "beat"

  def load_archive

    @comic_dates = {}
    @comic_titles = {}

    # Load Asynchronusly
    EM.next_tick do
      id_parse = /(\d+)/ # ID parsing regexp
      archive = Nokogiri::HTML(open('http://xkcd.com/archive/'))

      archive.css('#middleContainer > a').each do |data|
        if(match = id_parse.match(data[:href]))
          comic_id = match.captures.first.to_i
          @comic_dates.merge! comic_id => data[:title]
          @comic_titles.merge! comic_id => data.inner_html
          # puts "#{comic_id} #{data.inner_html} #{data[:title]}\n"
        end
      end
      @last_comic = @comic_titles.count
      @comic_count = @last_comic.to_i

      @dbready = true

      # puts @comic_titles.inspect
      # puts @comic_dates.inspect

      # print out the number of records
      puts "xkcd: Loaded #{@last_comic} comics"
    end # end EM
    "Refreshing Comics..."
  end

end
