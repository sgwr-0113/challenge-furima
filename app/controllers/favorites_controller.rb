class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  # お気に入り登録
  def create
    @favorite = Favorite.create(user_id: current_user.id, item_id: @item.id)
    count_favorites
  end
  # お気に入り削除
  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, item_id: @item.id)
    @favorite.destroy
    count_favorites
  end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end

  def count_favorites
    @favorites_count = Favorite.where(item_id: @item.id).count
  end
end
