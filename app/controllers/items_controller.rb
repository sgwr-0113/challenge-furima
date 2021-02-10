class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :purchase_confirm, :purchase]
  before_action :select_item, only: [:show, :edit, :update, :destroy, :purchase_confirm, :purchase]
  before_action :set_item_form, only: [:edit, :update]
  before_action :sold_item, only: [:purchase_confirm, :purchase]
  before_action :current_user_has_not_card, only: [:purchase_confirm, :purchase]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item_form = ItemForm.new
  end

  def create
    @item_form = ItemForm.new(item_form_params)
    # バリデーションで問題があれば、保存はされず「商品出品画面」を再描画
    if @item_form.valid?
      @item_form.save
      return redirect_to root_path
    end
    # アクションのnewをコールすると、エラーメッセージが入った@itemが上書きされてしまうので注意
    render 'new'
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
    @favorites_count = Favorite.where(item_id: @item.id).count
  end

  def edit
    @item_form.tag_name = @item.tags.first&.name
    redirect_to root_path if current_user.id != @item.user_id
  end

  def update
    render 'edit' unless current_user.id == @item.user.id
    @item_form = ItemForm.new(item_form_params)
    if @item_form.update(item_form_params, @item)
      return redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def purchase_confirm
    @address = Address.new
  end

  def purchase
    ## 購入履歴オブジェクトを定義
    order = Order.new(item_id: @item.id, user_id: current_user.id)

    ## 購入履歴オブジェクトに紐づく配送先オブジェクトを定義
    @address = order.build_address(address_params)
    if @address.valid?
      ## 配送先を保存できるとき
      Payjp.api_key = ENV['PAYJP_SK']      
      Payjp::Charge.create(
        amount: @item.price,
        customer: current_user.card.customer_token,  ## 顧客のトークンを渡す
        currency: 'jpy'
      )

      @address.save
      redirect_to root_path
    else
      ## 配送先を保存できないとき
      redirect_to purchase_confirm_item_path(@item)
    end
  end

  def search
    ## params[:q]がnilではなくて尚且つparams[:q][:name]がnilではないとき
    if params[:q]&.dig(:name)  ## if params[:q] && params[:q][:name]と同じようなもの
      ## squishメソッドで無駄なスペースを圧縮する
      ## 例えば "hoge         fuga    foo  bar"は"hoge fuga foo bar"になる
      squished_keywords = params[:q][:name].squish
      ## 半角スペースを区切り文字として配列にしてparamsに入れる
      ## 例えば文字列"hoge fuga foo bar"は配列[hoge, fuga, foo, bar]になる
      params[:q][:name_cont_any] = squished_keywords.split(" ")
    end

    @q = Item.ransack(params[:q])
    @items = @q.result
  end

  private
  def item_form_params
    params.require(:item_form).permit(
      :name,
      :price,
      :info,
      :scheduled_delivery_id,
      :shipping_fee_status_id,
      :prefecture_id,
      :sales_status_id,
      :category_id,
      :tag_name, 
      {images: []}     
    ).merge(user_id: current_user.id)
  end

  def address_params
    params.permit(
      :postal_code,
      :prefecture,
      :city,
      :addresses,
      :building,
      :phone_number
    )
  end

  def select_item
    @item = Item.find(params[:id])
  end

  def set_item_form
    item_attributes = @item.attributes
    @item_form = ItemForm.new(item_attributes)
  end

  ## 購入履歴がある（売り切れ）なら商品の詳細ページにリダイレクト
  def sold_item
    redirect_to item_path(@item), alert: "売り切れの商品です" if @item.order.present?
  end

  ## ユーザーがカードを登録していないならカードの登録ページにリダイレクト
  def current_user_has_not_card
    redirect_to new_card_path, alert: "クレジットカードが登録されていません" unless current_user.card.present?
  end

  def favorites_count
    
  end
end
