require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  setup do
    Dir.mkdir("public/test_images")
    @image_path = 'public/test_images/image.png'
    open(@image_path, 'wb') do |file|
      file << open(Faker::Avatar.image).read
    end
    @demo_file = File.new(File.join(Rails.root, @image_path))
  end
  teardown do
    FileUtils.rm_rf('public/test_images')
    FileUtils.rm_rf('public/uploads')
  end
  test 'upload product image' do
    product = products(:product_default).tap do |product|
      product.images.build(asset: @demo_file)
    end
    assert_equal 'image.png', product.images[0].asset.file.filename,
                'should retrun image name'
  end
end
