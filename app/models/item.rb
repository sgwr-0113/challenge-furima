class Item < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one :order
  has_many :comments
  has_many :item_tag_relations, dependent: :destroy
  has_many :tags, through: :item_tag_relations

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

  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than: 10000000 , message: 'は300円以上1000万円未満の範囲で入力してください' }
  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'は半角数字で入力してください' }



  def previous
    Item.where("id < ?", self.id).order("id DESC").first
  end

  def next
    Item.where("id > ?", self.id).order("id ASC").first
  end
end
