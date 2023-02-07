class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, foreign_key: 'recipe_id'

  def total_price
    recipefoods = RecipeFood.includes(:food).where(recipe_id: id)
    total = 0
    recipefoods.each do |item| 
      cost = item.food.price * item.quantity
      total += cost
    end
    total
  end

  def total_items
    recipefoods = RecipeFood.where(recipe_id: id)
    recipefoods.length
  end
end
