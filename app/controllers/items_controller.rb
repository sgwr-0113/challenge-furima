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
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def edit
    redirect_to root_path if current_user.id != @item.user_id
  end

  def update
    @item.update(item_params) if current_user.id == @item.user_id
    return redirect_to item_path if @item.valid?
    render 'edit'
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private
  def item_params
    params.require(:item).permit(
      :name,
      :price,
      :info,
      :scheduled_delivery_id,
      :shipping_fee_status_id,
      :prefecture_id,
      :sales_status_id,
      :category_id,
      {images: []}     
    ).merge(user_id: current_user.id)
  end

  def select_item
    @item = Item.find(params[:id])
  end
end
