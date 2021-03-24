class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :select_item, only: [:index, :create]
  before_action :set_membership, only: [:index, :create]

  def index
    return redirect_to root_path if current_user.id == select_item.user_id || select_item.order
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      if total_payment(current_user).between?(30000, 49999) && @m.rank_id == 0
        @m.update(rank_id: 1)
      elsif total_payment(current_user).between?(50000, 99999) && @m.rank_id <= 1
        @m.update(rank_id: 2)
      elsif total_payment(current_user) >= 100000 && @m.rank_id <= 2
        @m.update(rank_id: 3)
      end
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.permit(:token, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SK"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency:'jpy'
    )
  end

  def select_item
    @item = Item.find(params[:item_id])
  end

  def set_membership
    @m = current_user.membership
  end
end
