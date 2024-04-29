# class for creating exchange and binding queue orders
module Spree
  module Rmq
    module Orders
      module Producers
        class Paid
          prepend Spree::ServiceModule::Base

          def call(payload:)
            connection = Spree::Rmq::Connection.new
            channel = connection.connection.channel

            exchange = channel.headers('syncomm')
            paid_orders = channel.queue('orders', durable: true, auto_delete: false)

            paid_orders.bind(exchange, arguments:
                              {
                                object_type: 'Spree::Order',
                                routing_key: 'Spree::Store',
                                'x\-match' => 'all'
                              })

            res = exchange.publish(payload.to_json, routing_key: 'order', headers: { order_type: 'Spree::Order', routing_key: 'Spree::Store' })

            success(res)
          end
        end
      end
    end
  end
end
