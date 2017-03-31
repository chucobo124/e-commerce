module PictureHelper
  def create_picture(items_number)
    images = []
    image_path = 'public/test_images'
    Dir.mkdir(image_path) unless File.directory?(image_path)
    items_number.times do |index|
      current_image_path = "#{image_path}/image#{index}.png"
      next if File.exist? current_image_path
      MiniMagick::Image.open(Faker::Avatar.image).combine_options do |img|
        img.write current_image_path
        img.flip
      end
      images << fixture_file_upload(current_image_path, 'image/png')
    end
    images
  end

  def remove_picture
    FileUtils.rm_rf(File.join(Rails.root, 'public/test_images'))
    FileUtils.rm_rf(File.join(Rails.root, 'public/uploads'))
  end
end
