class Ingredient < ApplicationRecord
  has_many :items
  has_many :recipes, through: :items
  has_many :quantities
end
