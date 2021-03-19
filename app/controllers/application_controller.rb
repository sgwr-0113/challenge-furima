class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  def total_payment(user)
    bought_items = Item.joins(:order).select('items.*, orders.user_id').where(orders: {user_id: user.id}) # itemsとordersテーブルを結合し、orders側のuser_idが指定のユーザーと合致するレコードのみを取得
    bought_items.all.sum(:price).to_i
  end

  def total_sales(user)
    sold_items = Item.joins(:order).select('items.*, items.user_id').where(items: {user_id: user.id}) # itemsとordersテーブルを結合し、items側user_idが指定のユーザーと合致するレコードのみを取得
    sold_items.all.sum(:price).to_i
  end

  private
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date])
  end
  
end
