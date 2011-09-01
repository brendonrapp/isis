require 'twss'
require 'isis/plugins/base'

# Monkeypatching TWSS library to return
# value instead of true/false, so that
# we can tailor chat messages based on
# magnitude of she-said-it-ness
#
module TWSS
  class Engine
    def classify(str)
      if basic_conditions_met?(str)
        c = @classifier.classifications(str)
        require 'pp'
        # c[TRUE] - c[FALSE] > threshold
        c[TRUE] - c[FALSE]
      else
        # false
        0.0
      end
    end 
  end
end

class Isis::Plugin::TWSS < Isis::Plugin::Base

  def initialize
    @threshold = 30.0
  end

  def respond_to_msg?(msg, speaker)
    # don't bother parsing if it's a command string
    if msg[0] == "!"
      false
    else
      @shesaid = TWSS(msg)
      @shesaid > @threshold
    end
  end

  def response
    case @shesaid
    when 0.5..2
      "that's what she said"
    when 2..5
      "That's what she said!"
    when 5..99
      "THAT'S WHAT SHE SAID!!"
    else
      nil
    end
  end
end
