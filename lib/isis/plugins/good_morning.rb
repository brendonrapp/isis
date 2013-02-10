# require 'isis/plugins/base'
require 'gdbm'
require 'time'
require 'tzinfo'

class Isis::Plugin::GoodMorning < Isis::Plugin::Base
  
  BEGIN_MORNING = 7
  END_MORNING = 12
  END_DAY = 18

  def initialize
    @db = GDBM.new('goodmorning.db')
    @tz = TZInfo::Timezone.get("America/Los_Angeles") 
  end

  def respond_to_msg?(msg, speaker)
    false
  end

  def response
    nil
  end

  def joined(name)
    last_seen = Time._load(@db[name]) unless @db[name].nil?
    now = @tz.utc_to_local(Time.new.utc)
    response = nil

    unless last_seen.nil? or last_seen.strftime("%F") == now.strftime("%F")
      if now.hour > BEGIN_MORNING and now.hour < END_MORNING
        response = "Good morning, #{name}!"
        response += " I hope you had a good weekend." if now.monday?
      end
    end

    # marshal the new date, but let's ignore connections outside the workday
    @db[name] = now._dump if now.hour > BEGIN_MORNING and now.hour < END_DAY

    response
  end
end
