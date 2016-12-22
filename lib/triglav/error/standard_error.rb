module Triglav
  module Error
    class StandardError < ::StandardError

      attr_reader :code, :message

      def initialize(message = nil)
        @code = 500
        @message = message || "Some error was occurred."
      end

    end
  end
end
