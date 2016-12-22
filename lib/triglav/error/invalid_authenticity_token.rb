module Triglav
  module Error
    class InvalidAuthenticityToken < Triglav::Error::StandardError
      def initialize
        @code = 401
        @message = "Unauthenticated. Invalid or expired token."
      end
    end
  end
end
