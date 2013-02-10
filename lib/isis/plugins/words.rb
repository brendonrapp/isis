require 'isis/plugins/base'
require 'gdbm'
require 'time'

class Isis::Plugin::Words < Isis::Plugin::Base
  
  def initialize
    @db = GDBM.new('words.db')
    @tz = TZInfo::Timezone.get("America/Los_Angeles")
  end

  def respond_to_msg?(msg, speaker)
    # Process messages, only on Mon - Fri
    now = @tz.utc_to_local(Time.now)
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
    now = @tz.utc_to_local(Time.now)
    response = nil
    if now.hour == 8 and now.hour == 10 and (1..5).include? now.day and not @last_announcement == now.day
      response = announce_word(now.day)
      clear_db
    end
    response
  end

  private
  def parse_message(msg)
    msg.split(" ").each do |w|
      word = w.downcase
      if word.length > 3 and not IGNORED_WORDS.include? word
        @db[word] = 0 if @db[word].nil?
        @db[word] += 1
      end
    end
  end

  def announce_word(day)
    high_key, high_val = "", 0
    @db.each do |key, val|
      if val > high_val
        high_val = val
        high_key = key
      end
    end
    day_label = (day == 1 ? "Friday's" : "Yesterday's")
    ["WORD OF THE DAY", "#{day_label} word of the day was: #{high_key.titleize}"]
    @last_announcement = now.day
  end

  def clear_db
    @db.clear
  end
  
  # words to ignore - employee names, etc.
  IGNORED_WORDS = %w(linda kristi brendon cory liv noni jeremy winston eason renee)
end
