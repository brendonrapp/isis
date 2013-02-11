require 'isis/plugins/base'
require 'gdbm'
require 'time'
require 'tzinfo'

class Isis::Plugin::Words < Isis::Plugin::Base
  
  def initialize
    @db = GDBM.new('words.db')
    @tz = TZInfo::Timezone.get("America/Los_Angeles")
  end

  def respond_to_msg?(msg, speaker)
    # Process messages, only on Mon - Fri
    now = @tz.utc_to_local(Time.new.utc)
    unless now.saturday? or now.sunday?
      parse_message(msg)
    end
    false
  end

  def response
    nil
  end

  def timer_response
    # Announce it at 8:10 am Pacific
    now = @tz.utc_to_local(Time.new.utc)
    resp = nil
    if now.hour == 8 and now.min == 10 and (1..5).include? now.wday and not @last_announcement == now.day
      resp = announce_word(now)
      puts resp.to_s
      @last_announcement = now.day
      reset
    end
    # resp
    # Disabled output for now
    nil
  end

  def reset
    clear_log
  end

  private
  def parse_message(msg)
    msg.split(" ").each do |w|
      word = w.downcase
      if word.length > 3 and not IGNORED_WORDS.include? word
        @db[word] = "0" if @db[word].nil?
        val = @db[word].to_i
        val += 1
        @db[word] = val.to_s
      end
    end
  end

  def announce_word(now)
    high_key, high_val = "", 0
    @db.each do |key, val|
      if val.to_i > high_val
        high_val = val.to_i
        high_key = key
      end
    end
    day_label = (now.wday == 1 ? "Friday's" : "Yesterday's")
    ["WORD OF THE DAY", "#{day_label} word of the day was: #{high_key.capitalize}"]
  end

  def clear_log
    @db.clear
  end
  
  # words to ignore - employee names, etc.
  IGNORED_WORDS = %w(linda kristi brendon cory liv noni jeremy winston eason renee)
end
