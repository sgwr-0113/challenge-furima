class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
  end

  private
  def item_params
    params.requre(:item).permit(
      :image,
      :name,
      :price,
      :info,
      :scheduled_delivery_id,
      :shipping_fee_status_id,
      :prefecture_id,
      :sales_status_id,
      :category_id      
    ).merge(user_id: current_user.id)
  end
end
