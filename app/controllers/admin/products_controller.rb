class Admin::ProductsController < Admin::ApplicationController
  def index
    @product = Product.all
  end

  def create
    images = _create_image_object
    product = Product.create(_product_params)
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
    redirect_to admin_products_path
  end

  private

  def _product_params
    params.require(:product).permit(:name, :description, :price, :discount_price)
  end
end
