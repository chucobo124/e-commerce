class HomesController < ApplicationController
  def index
    @variants = Variant.where(visible: true).
      where.not(product_id: nil).page params[:id]
  end
end
