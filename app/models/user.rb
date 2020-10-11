class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_secure_password
end
