require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  include PictureHelper
  setup do
    @demo_file = create_picture
  end
  teardown do
    remove_picture
  end
  test 'upload product image' do
    product = products(:product_default).tap do |product|
      product.images.build(asset: @demo_file)
    end
    assert_equal 'image.png', product.images[0].asset.file.filename,
                'should retrun image name'
  end
end
