require 'test_helper'

class AdminProductsControllerTest < ActionDispatch::IntegrationTest
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
    get admin_products_url
    assert_response :success, 'should be successful'
  end
  test 'create' do
    post admin_products_url,
         params: {
           product: {
             name: @example_product[:name],
             description: @example_product[:description],
             price: @example_product[:price],
             discount_price: @example_product[:discount_price]
           }
         }
    _check_product_attr(@example_product)
    assert_redirected_to admin_products_path
  end
  test 'update' do
    product = products(:product_one)
    put admin_product_url(id: product.id), params: {
      product: {
        name: @example_product[:name],
        description: @example_product[:description],
        price: @example_product[:price],
        discount_price: @example_product[:discount_price]
      }
    }
    _check_product_attr(@example_product)
    assert_redirected_to admin_products_path
  end

  private

  def _check_product_attr(product)
    expect_product = Product.find_by_name(product[:name])
    assert_equal product[:name], expect_product.name,
                 'should create a product which got name'
    assert_equal product[:description], expect_product.description,
                 'should create a product which got description'
    assert_equal product[:price], expect_product.price,
                 'should create a product which got price'
    assert_equal product[:discount_price], expect_product.discount_price,
                 'should create a product which got discount_price'
  end
end
