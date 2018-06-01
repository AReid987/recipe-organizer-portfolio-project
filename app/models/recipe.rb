class Recipe < ApplicationRecord
  belongs_to :user
  has_many :items
  has_many :ingredients, through: :items

  validates :name, presence: true
end
