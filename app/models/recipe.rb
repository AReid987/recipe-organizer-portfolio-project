class Recipe < ApplicationRecord
  belongs_to :user
  has_many :items
  has_many :ingredients, through: :items
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
  validates :name, presence: true
end
