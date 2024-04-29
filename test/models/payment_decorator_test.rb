require 'test_helper'

# Some example of future test cases
class PaymentDecoratorTest < ActiveSupport::TestCase
  test 'when payment completed, order not paid' do
    # do not send message to queue orders
    assert true
  end

  test 'when payment completed, order paid' do
    # send message to queue orders with proper payload
    assert true
  end
end
