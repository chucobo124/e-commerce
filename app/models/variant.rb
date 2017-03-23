class Variant < ApplicationRecord
  include AASM
  before_save :_check_state
  aasm column: :state do
    state :unlisted, initial: true
    state :listed
    state :sold_out
    state :discontinued

    event :listing do
      transitions from: [:listed, :unlisted, :sold_out, :discontinued],
                  to: :listed, if: :_is_count_on_hand?
    end

    event :mark_as_sold do
      transitions from: [:sold_out, :listed], to: :sold_out,
                  unless: :_is_count_on_hand?
    end

    event :discontinue do
      transitions from: [:discontinued, :listed, :sold_out], to: :discontinued
    end
  end

  # It's an belongs to function but there is an error when add the callback.
  # Need to fix rails afterwards.
  #
  # @return [Object] product object
  def product
    Product.find product_id
  end

  private

  def _is_count_on_hand?
    count_on_hand > 0
  end

  def _check_state
    return if discontinued?
    if _is_count_on_hand?
      !listed? ? listing : return
    else
      !sold_out? ? mark_as_sold : return
    end
  end
end
