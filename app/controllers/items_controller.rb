class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :select_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def item_params
    params.require(:item).permit(
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

  def select_item
    @item = Item.find(params[:id])
  end
end
