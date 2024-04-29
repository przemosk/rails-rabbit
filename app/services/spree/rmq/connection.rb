require 'bunny'

module Spree
  module Rmq
    class Connection
      def initialize
        @connection = Bunny.new(Rails.configuration.amqp_url)
        @connection.start
      end

      attr_accessor :connection
    end
  end
end
