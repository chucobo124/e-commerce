class Order < ApplicationRecord
  include AASM
  belongs_to :user
  has_many :variants
  has_many :line_items
  aasm column: :state do
    state :in_progress, initial: true
    state :ready_to_pay
    state :purchased
    state :shipped
    state :completed
    state :error
    event :prepare_to_pay do
      transitions form: :in_progress, to: :ready_to_pay
    end
    event :shipping do
      transitions form: :purchased, to: :shipped
    end
    event :complete do
      transitions form: :shipped, to: :completed
    end
  end
end
