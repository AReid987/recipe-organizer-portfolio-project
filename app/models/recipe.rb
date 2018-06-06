class Recipe < ApplicationRecord
  belongs_to :user
  has_many :items
  has_many :ingredients, through: :items
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true

  def ingredients_attributes=(ingredient_attributes)

    ingredient_attributes.values.each do |ingredient_attribute|
      
      ingredient = Ingredient.find_or_create_by(name: ingredient_attribute[:name])
      self.ingredients << ingredient
    end
  end
end
