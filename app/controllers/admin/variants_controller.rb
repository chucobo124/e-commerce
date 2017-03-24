class Admin::VariantsController < Admin::ApplicationController
  before_action :_product, except: :index
  def index
    @variants = Variant.all
  end

  def new
    @variant = Product.find(params[:product_id]).variants.new
  end

  def edit
    @variant = Product.find(params[:product_id]).variants.find(params[:id])
  end

  def create
    _product.variants.create _variant_params
    redirect_to edit_admin_product_url params[:product_id]
  end

  def update
    _product.variants.find(params[:id]).update(_variant_params)
    redirect_to edit_admin_product_url params[:product_id]
  end

  def destroy
    _product.variants.find(params[:id]).destroy
    redirect_to edit_admin_product_url params[:product_id]
  end

  private

  def _product
    Product.find params[:product_id]
  end

  def _variant_params
    params.require(:variant).permit(:sku, :name, :count_on_hand, :visible, :is_default)
  end
end
