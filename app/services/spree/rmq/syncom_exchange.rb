# Class which can be used for create
module Spree
  module Rmq
    class SyncomExchange
      def initialize(connection: Spree::Rmq::Connection.new)
        @connection = connection
      end

      attr_accessor :connection

      def create
        channel = connection.channel

        exchange = Bunny::Exchange.new(channel, :headers, 'syncomm')
        paid_orders = channel.queue('orders', durable: true, auto_delete: false)

        paid_orders.bind(exchange, arguments: { object_type: 'Spree::Order', routing_key: 'Spree::Store', 'x\-match' => 'all'})
      end
    end
  end
end
