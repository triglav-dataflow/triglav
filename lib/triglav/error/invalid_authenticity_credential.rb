module Triglav
  module Error
    class InvalidAuthenticityCredential < Triglav::Error::StandardError
      def initialize
        @code = 401
        @message = 'Not authenticated. Invalid authenticity credential.'
      end
    end
  end
end
