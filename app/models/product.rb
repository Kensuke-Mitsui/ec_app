class Product < ApplicationRecord
  # 画像を複数枚投稿できるようにする
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

  #バリデーション
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  # validates :unit, presence: true
end
