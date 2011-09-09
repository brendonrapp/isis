require 'isis/plugins/base'

class Isis::Plugin::Olaf < Isis::Plugin::Base

  def respond_to_msg?(msg, speaker)
    @commands = msg.split
    @commands[0].downcase == "!olaf" ? true : false
  end

  def response
    case @commands[1].downcase
    when "metal"
      "http://img834.imageshack.us/img834/5195/metalface.jpg"
    when "berserker"
      "http://www.youtube.com/watch?v=I4E08zeCqjo"
    when "berzerker"
      "http://www.youtube.com/watch?v=I4E08zeCqjo"
    when "sing"
      "http://www.youtube.com/watch?v=I4E08zeCqjo"
    when "girl"
      "Skrelnick"
    when "home"
      "Moscow"
    when "where"
      "Moscow"
    when "commands"
      "Understood commands for !olaf: metal, berserker"
    else
      nil
    end
  end
end
