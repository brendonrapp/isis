require 'isis/plugins/base'
require 'ruby-hackernews'
require 'tzinfo'

class Isis::Plugin::HackerNews < Isis::Plugin::Base

  TRIGGERS = %w(!hn !hackernews)

  def initialize
    @tz = TZInfo::Timezone.get("America/Los_Angeles") 
  end

  def respond_to_msg?(msg, speaker)
    TRIGGERS.include? msg.downcase
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
    # News at 8:12 am
    if now.hour == 8 and now.min == 12 and (1..5).include? now.wday and not announced_today?(now.day)
      resp = headlines
      @last_announced = now.day
    end
    resp
  end

  private
  def headlines
    entries = RubyHackernews::Entry.all[0..4]
    output = "Top stories on HackerNews<br>"
    entries.each do |e|
      output += "<a href=\"#{e.link.href}\">#{e.link.title}</a> (#{e.voting.score} points by #{e.user.name})<br>"
    end
    output
  end

  def announced_today?(today)
    @last_announced == today
  end
end
