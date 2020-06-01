class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #アソシエーション
  has_many :addresses

  #deviseのバリデーション
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable
end
