class Admin::VariantsController < Admin::ApplicationController
  def index
  end

  def create
    product = Product.find params[:product_id]
    product.variants.create(_variant_params)
    redirect_to admin_product_variants_url
  end

  private

  def _variant_params
    params[:variant][:count_on_hand] = params[:variant][:count_on_hand].to_i
    params.require(:variant).permit(:sku, :count_on_hand, :visible, :is_default)
  end
end
