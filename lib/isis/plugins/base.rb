# Plugin base class

module Isis
  module Plugin
    class Base
      def receive_message(msg, speaker)
        self.respond_to_msg?(msg, speaker) ? self.response : nil
      end
    end
  end
end
