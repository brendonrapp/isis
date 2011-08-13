# Plugin base class

module Isis
  module Plugin
    class Base
      def receive_message(msg)
        self.respond_to_msg?(msg) ? self.response : nil
      end
    end
  end
end
