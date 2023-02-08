require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before :all do
    user = User.first
    food = Food.create(name: 'foodstuff', measurement_unit: 'gr', price: 20, quantity: 1, user: user)
    recipe = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem', public: true, user: user)
    recipe_food = RecipeFood.create(quantity: 5, food: food, recipe: recipe)
    
    user.save
    food.save
    recipe.save
    recipe_food.save
  end
  it 'quantity should not be smaller than 1' do
    recipefood = RecipeFood.first
    recipefood.quantity = 0
    expect(recipefood).to_not be_valid
  end
end