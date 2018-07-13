class ItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :ingredient_id
  belongs_to :ingredient
end
