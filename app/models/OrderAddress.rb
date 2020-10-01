class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :token, :postal_code, :prefecture, :city, :addresses, :building, :phone_number, :user_id


  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture: prefecture, city: city, address: addresses, building: building, phone_number: phone_number, order_id: order.id)
  end
end