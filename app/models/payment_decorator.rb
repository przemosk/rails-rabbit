
module PaymentDecorator
  def after_completed
    serialized_order = OrderSerializer.new(order: order).serialized_hash

    # TODO: consider move it into background job
    Spree::Rmq::Orders::Producers::Paid.call(payload: serialized_order) if order.paid?
  end
end
Spree::Payment.prepend PaymentDecorator
