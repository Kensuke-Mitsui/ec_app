class CreditCard < ApplicationRecord
  belongs_to :user

  #バリデーション
  validates :user_id, :customer_id, :card_id, presence: true
end
