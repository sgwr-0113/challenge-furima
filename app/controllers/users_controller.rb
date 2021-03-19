class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  
  def show
    ## お気に入り一覧
    favorites = Favorite.where(user_id: current_user.id).pluck(:item_id)  # ログイン中のユーザーのお気に入りのitem_idカラムを取得
    @favorite_items = Item.find(favorites)     # itemsテーブルから、お気に入り登録済みのレコードを取得

    ## DM機能
    @user = User.find(params[:id])
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    if @user.id != current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
    end

    @m = @user.membership

    ## 売買履歴
    @total_pay = total_payment(@user)
    @total_sales = total_sales(@user)

    ## カードが登録されていないならここで終了
    return unless current_user.card.present?
    Payjp.api_key = ENV["PAYJP_SK"] # 環境変数を読み込む
    customer = Payjp::Customer.retrieve(current_user.card.customer_token) # 先程のカード情報を元に、顧客情報を取得
    @card = customer.cards.first
  end
end
