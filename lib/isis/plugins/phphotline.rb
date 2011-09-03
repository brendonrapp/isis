require 'isis/plugins/base'

class Isis::Plugin::PHPHotline < Isis::Plugin::Base

  BETTER_LANGUAGES = ["Ruby", "Python", "Clojure", "Scala", "Scheme", "Haskell", "Erlang", "Java", "COBOL"]
  def respond_to_msg?(msg, speaker)
    @commands = msg.split
    @commands[0].downcase == "!phphotline" ? true : false
  end

  def response
    "Just switch to #{BETTER_LANGUAGES[rand(BETTER_LANGUAGES.size)]}" 
  end
end
