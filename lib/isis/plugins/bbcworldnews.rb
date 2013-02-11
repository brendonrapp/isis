require 'isis/plugins/base'
require 'nokogiri'
require 'open-uri'
require 'tzinfo'

class Isis::Plugin::BBCWorldNews < Isis::Plugin::Base

  def initialize
    @tz = TZInfo::Timezone.get("America/Los_Angeles") 
  end

  def respond_to_msg?(msg, speaker)
    msg.downcase == "!bbc"
  end

  def response
    headlines
  end

  def response_type
    "html"
  end

  def timed_response
    now = @tz.utc_to_local(Time.new.utc)
    resp = nil
    # News at 8:13 am
    if now.hour == 8 and now.min == 13 and (1..5).include? now.wday and not announced_today?(now.day)
      resp = headlines
      @last_announced = now.day
    end
    resp
  end

  private
  def headlines
    output = "Top stories from BBC World News<br>"
    page = Nokogiri::HTML(open('http://www.bbc.co.uk/news/10628323'))
    articles = page.css('#range-top-stories ul li')
    articles.each do |a|
      output += "<a href=\"http://www.bbc.co.uk#{a.css("a").attr("href").value}\">#{a.text.gsub(/(\n|\t)/, "")}</a><br>"
    end
    output
  end

  def announced_today?(today)
    @last_announced == today
  end
end
