module PictureHelper
  def create_picture
    Dir.mkdir('public/test_images')
    image_path = 'public/test_images/image.png'
    File.new(File.join(Rails.root, image_path), 'wb')
  end

  def remove_picture
    FileUtils.rm_rf('public/test_images')
    FileUtils.rm_rf('public/uploads')
  end
end
