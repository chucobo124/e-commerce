require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test 'prepare_to_pay' do
    order = orders(:order_default).tap do |order|
      order.prepare_to_pay
    end
    assert_equal 'ready_to_pay', order.state, 'state should return ready_to_pay'
  end
  test 'shipping' do
    order = orders(:order_default).tap do |order|
      order.shipping
    end
    assert_equal 'shipped', order.state, 'state should return shipped'
  end
  test 'complete' do
    order = orders(:order_default).tap do |order|
      order.complete
    end
    assert_equal 'completed', order.state, 'state should return completed'
  end
end
