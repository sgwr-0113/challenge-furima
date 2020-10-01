class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :token, :postal_code, :prefecture, :city, :addresses, :building, :phone_number, :user_id

  with_options presence: true do
    validates :token, presence: { message: "can't be blank" }
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: "Input correctly" }
    validates :prefecture, numericality: { other_than: 0, message: "Select" }
    validates :city
    validates :addresses
    validates :phone_number, length: { maximum: 11, message: "Too long" }
    validates :user_id
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture: prefecture, city: city, addresses: addresses, building: building, phone_number: phone_number, order_id: order.id)
  end
end