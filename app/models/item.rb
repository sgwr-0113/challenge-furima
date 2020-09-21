class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image

  belongs_to_active_hash :scheduled_delivery
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :sales_status
  belongs_to_active_hash :category

  with_options presence: true do
    validates :name
    validates :price
    validates :info
    validates :image
  end

  validates :name,
  :price,
  :info,
  :scheduled_delivery_id,
  :shipping_fee_status_id,
  :prefecture_id,
  :sales_status_id,
  :category_id
end
