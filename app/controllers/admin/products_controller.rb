class Admin::ProductsController < AdminApplicationController
  def index
    @product = Product.all
  end
  def create
    Product.create(person_params)
    redirect_to admin_products_path
  end

  def update
    Product.update(person_params)
    redirect_to admin_products_path
  end

  private

  def person_params
    params.require(:product).permit(:name, :description, :price, :discount_price)
  end
end
