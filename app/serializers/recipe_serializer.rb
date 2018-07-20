class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :instructions
  has_many :items
  has_many :comments
end
