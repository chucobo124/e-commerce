require 'test_helper'

class Admin::VariantsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:one)
    @product = products(:product_one)
    @example_variant = {
      sku: Faker::Code.asin,
      count_on_hand: 10,
      visible: true,
      is_default: true
    }
  end
  test 'index' do
    get admin_product_variants_url(product_id: @product.id)
    assert_response :success, 'should be successful'
  end
  test 'create' do
    post admin_product_variants_url(product_id: @product.id),
      params: {
        variant: @example_variant
      }
    _check_variant_attr(@example_variant)
    assert_redirected_to admin_product_variants_url
  end
  test 'update' do
    variant = variants(:variant_default)
    put admin_product_variant_url(id: variant.id,
      product_id: @product.id),
      params: {
        variant: @example_variant
      }
    _check_variant_attr(@example_variant)
    assert_redirected_to admin_product_variants_url
  end

  private

  def _check_variant_attr(variant)
    expect_variant = Variant.find_by_sku(variant[:sku])
    assert_equal variant[:sku], expect_variant.sku,
                 'should create a variant which got sku'
    assert_equal variant[:count_on_hand], expect_variant.count_on_hand,
                 'should create a variant which got count_on_hand'
    assert_equal variant[:visible], expect_variant.visible,
                 'should create a variant which got visible'
    assert_equal variant[:is_default], expect_variant.is_default,
                 'should create a variant which got is_default'
    assert_equal @product.id, expect_variant.product.id,
                 'should create a variant which got product_id'
  end
end
