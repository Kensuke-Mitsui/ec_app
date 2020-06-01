class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #アソシエーション
  has_many :addresses

  #バリデーション
  validates :password,           presence: true, length: {minimum: 7 }, confirmation: true
  validates :family_name,        presence: true
  validates :first_name,         presence: true
  validates :family_name_kana,   presence: true
  validates :first_name_kana,    presence: true
  validates :gender,             presence: true
  validates :birthday,           presence: true

  #deviseのバリデーション
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable
end
