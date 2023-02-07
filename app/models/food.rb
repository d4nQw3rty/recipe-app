class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy, foreign_key: 'food_id'
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
