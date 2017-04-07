require 'test_helper'

class Admin::OrdersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:user_default)
    @expect_line_items = {}
    line_items(:line_item_default_1, :line_item_default_2,
               :line_item_default_3).each do |line_item|
      @expect_line_items[line_item.variant.id] = {
        count: 10,
        price: Faker::Commerce.price
      }
    end
  end
  test '#create' do
    post orders_path, params: { orders: @expect_line_items }
    assert_redirected_to root_path
  end
end
