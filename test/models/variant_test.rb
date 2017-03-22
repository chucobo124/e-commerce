require 'test_helper'

class VariantTest < ActiveSupport::TestCase
  test 'state' do
    assert_equal variants(:default_state).state, 'unlisted',
      'should return default state unlisted'
  end

  test 'mark_as_sold' do
    variant = variants(:listed_state).tap do |variant|
      variant.update(count_on_hand: -1)
    end
    assert_equal 'sold_out', variant.state,
      'state should return sold_out'

    variant.update(count_on_hand: 10)
    assert_equal 'listed', variant.state,
      'state should return listed when count on hand more than 0'
  end

  test 'listing' do
    variant = variants(:default_state).tap do |variant|
      variant.update(count_on_hand: 10)
    end
    assert_equal 'listed', variant.state,
      'state should return listed'

    variant = variants(:default_state).tap do |variant|
      variant.update(count_on_hand: 0)
    end
    assert_equal 'sold_out', variant.state,
      'state should return sold_out when count on hand is 0'
  end

  test 'discontinued' do
    variant = variants(:listed_state).tap do |variant|
      variant.discontinue
    end
    assert_equal 'discontinued', variant.state,
      'state should return discontinued'

    variant = variants(:listed_state).tap do |variant|
      variant.discontinue
      variant.update(count_on_hand: 10)
    end
    assert_equal 'discontinued', variant.state,
      'state should return discontinued'
  end
end
