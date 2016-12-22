module Triglav
  module Error
    class BadRequest < Triglav::Error::StandardError

      def initialize(message = nil)
        @code = 400
        @message = message || "Bad request."
      end
    end
  end
end
