class Admin::VariantsController < Admin::ApplicationController
  before_action :_product
  def index
  end

  def new
    @variant = Product.find(params[:product_id]).variants.new
  end

  def create
    _product.variants.create _variant_params
    redirect_to admin_product_variants_url
  end

  def update
    _product.variants.find(params[:id]).update(_variant_params)
    redirect_to admin_product_variants_url
  end

  private

  def _product
    Product.find params[:product_id]
  end

  def _variant_params
    params.require(:variant).permit(:sku, :count_on_hand, :visible, :is_default)
  end
end
