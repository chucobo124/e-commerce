require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  test 'ready_to_pay' do
    line_item = line_items(:line_item_default).tap do |line_item|
      line_item.ready_to_pay
    end
    assert_equal 'in_payment', line_item.state, 'state should retrun in_payment'
  end
  test 'move_to_purchased' do
    line_item = line_items(:line_item_purchased).tap do |line_item|
      line_item.purchase
    end
    assert_equal 'purchased', line_item.state, 'state should retrun purchased'
  end
end
