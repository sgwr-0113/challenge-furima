class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  has_one :order
  has_many :comments

  with_options presence: true do
    validates :image
    validates :name
    validates :price
    validates :info
  end

  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than: 10000000 , message: 'Out of setting range' }
  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'Half-width number' }

  belongs_to_active_hash :scheduled_delivery
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :sales_status
  belongs_to_active_hash :category

  with_options presence: true, numericality: { other_than: 0, message: 'Select' }  do
    validates :scheduled_delivery_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :sales_status_id
    validates :category_id
  end
end
