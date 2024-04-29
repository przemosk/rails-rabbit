require 'test_helper'

# Some example of future test cases
class Spree::Rmq::Orders::Consumers::FulfilledTest < ActiveSupport::TestCase
  test 'when shipments emtpy' do
    # return failiure
    assert true
  end

  test 'when shipements not empty, but shipment not exists' do
    # return failiure
    assert true
  end

  test 'when shipements not empty, but shipment exists' do
    # update found shipment state
    # update odrer
    assert true
  end
end
