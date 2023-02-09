require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before :all do
    user = User.first
    food = Food.create(name: 'foodstuff', measurement_unit: 'gr', price: 20, quantity: 1, user:)
    recipe = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
                           public: true, user:)
    recipe_food = RecipeFood.create(quantity: 5, food:, recipe:)

    user.save
    food.save
    recipe.save
    recipe_food.save
  end

  it 'name should be present' do
    recipe = Recipe.first
    recipe.name = nil
    expect(recipe).to_not be_valid
  end

  it 'total_price should work' do
    recipe = Recipe.first
    expect(recipe.total_price).to eq(100)
  end

  it 'total_price should work' do
    recipe = Recipe.first
    expect(recipe.total_items).to eq(1)
  end
end
