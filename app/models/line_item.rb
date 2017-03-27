class LineItem < ApplicationRecord
  include AASM
  belongs_to :variant
  belongs_to :order
  aasm column: :state do
    state :in_cart, initial: true
    state :in_payment
    state :purchased
    state :error
    event :move_to_in_payment do
      transitions form: [:in_cart, :error], to: :in_payment
    end
    event :move_to_purchased do
      transitions form: [:in_payment], to: :purchased
    end
  end

  private

  def check_order_is_purchased
    order.state
  end
end
