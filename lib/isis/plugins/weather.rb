require 'isis/plugins/base'
require 'barometer'
require 'tzinfo'

class Isis::Plugin::Weather < Isis::Plugin::Base
  
  def initialize
    @tz = TZInfo::Timezone.get("America/Los_Angeles")
    Barometer.config = { 1 => :wunderground }
  end

  def respond_to_msg?(msg, speaker)
    msg.downcase == "!weather"
  end

  def response
    do_the_weather
  end

  def timed_response
    now = @tz.utc_to_local(Time.new.utc)
    resp = nil
    # Weather at 8:11 am!
    if now.hour == 8 and now.min == 11 and (1..5).include? now.wday and not announced_today?(now.day)
      resp = do_the_weather
    resp
  end

  private
  def do_the_weather
    now = @tz.utc_to_local(Time.new.utc)
    aptos = Barometer.new("95003").measure
    long_beach = Barometer.new("90806").measure
    austin = Barometer.new("78750").measure
    pismo = Barometer.new("93448").measure
    resp = ["ISIS Weather Report - #{now.strftime("%l:%M %P").strip} #{@tz.strftime("%Z")}"]
    [aptos, long_beach, austin, pismo].each { |w| resp << "#{forecast(w)}" }
    @last_announced = now.day
    resp
  end

  # Parse wunderground's icon codes into a text weather condition
  def parse_icon_codes(code)
    case code
    when "flurries", "rain", "sleet", "snow", "clear", "sunny", "cloudy", "fog", "hazy"
      code.capitalize
    when "chancerain", "chanceflurries", "chancesleet", "chancesnow"
      "Chance of #{code.split("chance")[1].capitalize}"
    when "nt_flurries", "nt_rain", "nt_sleet", "nt_snow"
      "#{code.split("_")[1].capitalize}"
    when "mostlysunny", "mostlycloudy"
      "Mostly #{code.split("mostly")[1].capitalize}"
    when "partlysunny", "partlycloudy"
      "Partly #{code.split("partly")[1].capitalize}"
    when "chancetstorms"
      "Chance of Thunderstorms"
    when "tstorms"
      "Thunderstorms"
    when "nt_tstorms"
      "Thunderstorms at Night"
    else
      "(no condition info)"
    end
  end

  def forecast(w)
    city = w.measurements.last.location.to_s.split(",")[0..1].join(",")
    "#{city} - Forecast: #{parse_icon_codes(w.today.icon)}, High #{w.today.high}, Low #{w.today.low}. Current Conditions: #{parse_icon_codes(w.now.icon)}, #{w.now.temperature}, wind #{w.now.wind} #{w.now.wind.direction}"
  end

  def announced_today?(today)
    @last_announced == today
  end
end
