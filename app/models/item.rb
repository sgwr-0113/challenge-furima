class Item < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one :order
  has_many :comments

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :scheduled_delivery
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :sales_status
  belongs_to :category

  with_options presence: true do
    validates :images
    validates :name
    validates :price
    validates :info
  end

  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than: 10000000 , message: 'Out of setting range' }
  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'Half-width number' }

  with_options presence: true, numericality: { other_than: 0, message: 'Select' }  do
    validates :scheduled_delivery_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :sales_status_id
    validates :category_id
  end

  def previous
    Item.where("id < ?", self.id).order("id DESC").first
  end

  def next
    Item.where("id > ?", self.id).order("id ASC").first
  end
end
