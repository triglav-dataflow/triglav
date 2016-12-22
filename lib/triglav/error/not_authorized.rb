module Triglav
  module Error
    class NotAuthorized < Triglav::Error::StandardError

      def initialize
        @code = 403
        @message = "Not authorized."
      end
    end
  end
end
