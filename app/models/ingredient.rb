class Ingredient < ApplicationRecord
  has_many :items
  has_many :recipes, through: :items
  has_many :quantities
  accepts_nested_attributes_for :quantities, reject_if: :all_blank, allow_destroy: true
end
