require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  test 'move_to_in_payment' do
    line_item = line_items(:line_item_default).tap do |line_item|
      line_item.move_to_in_payment
    end
    assert_equal 'in_payment', line_item.state, 'state should retrun in_payment'
  end
  test 'move_to_purchased' do
    line_item = line_items(:line_item_purchased).tap do |line_item|
      line_item.move_to_purchased
    end
    assert_equal 'purchased', line_item.state, 'state should retrun purchased'
  end
end
