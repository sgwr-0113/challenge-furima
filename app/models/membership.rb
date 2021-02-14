class Membership < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: "Input correctly" }
    validates :prefecture, numericality: { other_than: 0, message: "Select" }
    validates :city
    validates :addresses
    validates :phone_number, length: { maximum: 11, message: "Too long" }
  end
end
