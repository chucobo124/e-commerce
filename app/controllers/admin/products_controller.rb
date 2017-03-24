class Admin::ProductsController < Admin::ApplicationController
  def index
    @product = Product.all
  end

  def create
    Product.create(_person_params)
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
    Product.update(_person_params)
    redirect_to admin_products_path
  end

  private

  def _person_params
    params.require(:product).permit(:name, :description, :price, :discount_price)
  end
end
