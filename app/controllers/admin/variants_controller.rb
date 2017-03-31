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
    variant = _product.variants.create _variant_params
    _create_image_object.each_with_index do |image, index|
      if variant.images[index].blank?
        variant.images.create(asset: image)
      else
        variant.images[index].asset = image
      end
    end
    redirect_to edit_admin_product_url params[:product_id]
  end

  def update
    # images = _create_image_object
    variant = _product.variants.find(params[:id])
    variant.update(_variant_params)
    _create_image_object(variant)
    # images.each_with_index do |image, index|
    #   if variant.images[index].blank?
    #     variant.images.create(asset: image)
    #   else
    #     variant.images[index].asset = image
    #   end
    # end
    redirect_to edit_admin_product_url params[:product_id]
  end

  def destroy
    _product.variants.find(params[:id]).destroy
    redirect_to edit_admin_product_url params[:product_id]
  end

  private

  def _create_image_object(variant)
    images = []
    5.times do |index|
      params.require(:variant).permit(images: index.to_s).tap do |image|
        next if image['images'].blank?
        images << Image.create(asset: image['images'][index.to_s])
      end
    end
    variant.images << images
  end

  def _product
    Product.find params[:product_id]
  end

  def _variant_params
    params.require(:variant).permit(:sku, :name, :count_on_hand, :visible, :is_default)
  end
end
