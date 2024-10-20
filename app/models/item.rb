class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :lead_time

  validates :image, :name, :content, presence: true
  validates :category_id, :condition_id, :postage_id, :prefecture_id, :lead_time_id,
            numericality: { other_than: 1, message: "can't be blank" }
  validates :price, numericality: { in: 300..9_999_999, only_integer: true }

  has_one_attached :image
  belongs_to :user
  has_one :order
end
