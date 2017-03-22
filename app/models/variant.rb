class Variant < ApplicationRecord
  include AASM
  before_update :check_state
  aasm column: :state do
    state :unlisted, initial: true
    state :listed
    state :sold_out
    state :discontinued
    
    event :listing do
      transitions from: [:listed, :unlisted, :sold_out, :discontinued],
        to: :listed, if: :is_count_on_hand?
    end

    event :mark_as_sold do
      transitions from: [:sold_out, :listed], to: :sold_out,
                  unless: :is_count_on_hand?
    end

    event :discontinue do
      transitions from: [:discontinued, :listed, :sold_out], to: :discontinued
    end
  end

  private

  def is_count_on_hand?
    count_on_hand > 0
  end

  def check_state
    return unless !discontinued?
    if is_count_on_hand?
      !listed? ? listing : return
    else
      !sold_out? ? mark_as_sold : return
    end
  end
end
