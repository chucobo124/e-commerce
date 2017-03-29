class Admin::ProductsController < Admin::ApplicationController
  def index
    @product = Product.all
  end

  def create
    images = _create_image_object
    product = Product.create(_product_params)
    images.each do |image|
      product.images.create(asset: image)
    end
    product.save
    redirect_to admin_products_path
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find params[:id]
    @variants = Product.find(params[:id]).variants
  end

  def update
    images = _create_image_object
    product = Product.find params[:id]
    product.update(_product_params)
    images.each_with_index do |image, index|
      if product.images[index - 1].blank?
        product.images.create(asset: image)
      else
        product.images[index - 1].asset= image
      end
    end
    redirect_to admin_products_path
  end

  private

  def _create_image_object
    images = []
    5.times do |index|
      params.require(:product).permit(images: (index - 1).to_s).tap do |image|
        next if image['images'].blank?
        images << File.open(image['images'][(index - 1).to_s].path)
      end
    end
    images
  end

  def _product_params
    params.require(:product).permit(:name, :description, :price, :discount_price)
  end
end
