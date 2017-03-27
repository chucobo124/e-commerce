require 'test_helper'

class Admin::VariantsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:user_default)
    @product = products(:product_default)
    @example_variant = {
      sku: Faker::Code.asin,
      name: Faker::Commerce.product_name,
      count_on_hand: 10,
      visible: true,
      is_default: true
    }
  end
  test 'index' do
    get admin_variants_url
    assert_response :success, 'should be successful'
  end
  test 'create' do
    post admin_product_variants_url(product_id: @product.id),
         params: { variant: @example_variant }
    _check_variant_attr(@example_variant)
    assert_redirected_to edit_admin_product_url @product.id
  end
  test 'update' do
    variant = variants(:variant_listed_state)
    @product.variants << variant
    put admin_product_variant_url(id: variant.id, product_id: @product.id),
        params: { variant: @example_variant }
    _check_variant_attr(@example_variant)
    assert_redirected_to edit_admin_product_url @product.id
  end

  private

  def _check_variant_attr(variant)
    expect_variant = Variant.find_by_sku(variant[:sku])
    assert_equal variant[:sku], expect_variant.sku,
                 'should create a variant which got sku'
    assert_equal variant[:name], expect_variant.name,
                 'should create a variant which got name'
    assert_equal variant[:count_on_hand], expect_variant.count_on_hand,
                 'should create a variant which got count_on_hand'
    assert_equal variant[:visible], expect_variant.visible,
                 'should create a variant which got visible'
    assert_equal variant[:is_default], expect_variant.is_default,
                 'should create a variant which got is_default'
    assert_equal @product.id, expect_variant.product.first.id,
                 'should create a variant which got product_id'
  end
end
