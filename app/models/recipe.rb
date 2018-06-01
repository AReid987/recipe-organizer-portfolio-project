class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients
  has_many :items, through: :ingredients
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
  validates :name, presence: true
end
