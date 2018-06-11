class Recipe < ApplicationRecord
  belongs_to :user
  has_many :items
  has_many :ingredients, through: :items
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true

  def ingredients_attributes=(ingredient_attributes)

    ingredient_attributes.values.each do |ingredient_attribute|
      #byebug
      if ingredient_attribute[:_destroy] == '1'
        ingredient = Ingredient.find_or_create_by(name: ingredient_attribute['name'])
        ingredient.delete
      else
        ingredient = Ingredient.find_or_create_by(name: ingredient_attribute['name'])
        self.ingredients << ingredient unless self.ingredients.include?(ingredient)
      end
      ingredient_attribute[:items_attributes].values.each do |item_attribute|
        #byebug
        if self.items.any? do |item|
            item.recipe_id == self.id && item.ingredient_id == ingredient.id
          end
          item = self.items.select do |i|
            i.ingredient_id == ingredient.id && i.recipe_id == self.id
          end.first
          item.quantity = item_attribute unless item_attribute.blank?
          item.save
        else
          item = self.items.select {|i| i.ingredient_id == ingredient.id}.first
          item.quantity = item_attribute unless item_attribute.blank?
          item.save
        end
      end
    end
  end
end
