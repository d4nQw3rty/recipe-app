class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, foreign_key: 'recipe_id'
  validates :preparation_time, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cooking_time, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end