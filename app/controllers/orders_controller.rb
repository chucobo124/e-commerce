class OrdersController < ApplicationController
  before_action :authenticate_user!
  # Display List of Orders what user brought
  #
  # @return [Object] Orders List of Orders
  def index
  end

  # Create Order belongs to users line item
  #
  # @return [Object] Order Order with Line Items
  def new
  end

  # Order Create Proccess
  #
  # @return [302]  Redirection to payment
  def create
    order = Order.create user: current_user
    _line_items(order)
    order.prepare_to_pay!
    redirect_to root_path
  end

  private

  # Create line Items with Order object
  #
  # @param [Object] order Order Object
  # @return [Array] Line Items
  def _line_items(order)
    params.require(:orders).each do |variant_id, info|
      count = info.require(:count)
      price = info.require(:price)
      variant = Variant.find variant_id
      LineItem.create(variant_id: variant_id, order: order, quantity: count,
                      price: price).ready_to_pay!
    end
  end
end
