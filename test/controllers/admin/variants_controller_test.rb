require 'test_helper'

class Admin::VariantsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:one)
    @example_product = {
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      price: Faker::Commerce.price,
      discount_price: Faker::Commerce.price
    }
  end
  test 'index' do
    get admin_variants_url
    assert_response :success, 'should be successful'
  end
  test 'create' do
    post admin_variants_url,
         params: {
           product: {
             name: @example_product[:name],
             description: @example_product[:description],
             price: @example_product[:price],
             discount_price: @example_product[:discount_price]
           }
         }
    _check_product_attr(@example_product)
    assert_redirected_to admin_variants_url
  end
  test 'update' do
    product = products(:product_one)
    put admin_variant_url(id: product.id), params: {
      product: {
        name: @example_product[:name],
        description: @example_product[:description],
        price: @example_product[:price],
        discount_price: @example_product[:discount_price]
      }
    }
    _check_product_attr(@example_product)
    assert_redirected_to admin_variants_url
  end

  private

  def _check_product_attr(variant)
    expect_product = Product.find_by_name(variant[:name])
    assert_equal variant[:name], expect_product.name,
                 'should create a variant which got name'
    assert_equal variant[:description], expect_product.description,
                 'should create a variant which got description'
    assert_equal variant[:price], expect_product.price,
                 'should create a variant which got price'
    assert_equal variant[:discount_price], expect_product.discount_price,
                 'should create a variant which got discount_price'
  end
end
