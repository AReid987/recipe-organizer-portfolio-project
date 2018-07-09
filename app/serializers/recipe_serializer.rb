class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :instructions
  has_many :ingredients
  has_many :items 
end
