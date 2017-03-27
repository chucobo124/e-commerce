class LineItem < ApplicationRecord
  include AASM
  belongs_to :variant
  belongs_to :order
  aasm column: :state do
    state :in_cart, initial: true
    state :in_payment
    state :purchased
    state :error
    event :ready_to_pay do
      transitions form: [:in_cart, :error], to: :in_payment
    end
    event :purchase do
      transitions form: [:in_payment], to: :purchased,
        if: :check_order_is_purchased
    end
  end

  private

  def check_order_is_purchased
    order.purchased?
  end
end
