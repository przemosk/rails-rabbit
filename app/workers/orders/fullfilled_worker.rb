module Orders
  class FullfilledWorker
    include Sneakers::Worker
    from_queue "fulfilled.orders"

    def work(raw_event)
      message = JSON.parse(raw_event)
      Spree::Rmq::Orders::Consumers::Fulfilled.call(payload: message)
      ack!
    end
  end
end
