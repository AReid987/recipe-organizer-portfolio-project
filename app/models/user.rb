class User < ApplicationRecord
  has_secure_password
  has_many :recipes

  validates :name, presence: true
  validates :email, presence: true
  validates :username, uniqueness: true
end
