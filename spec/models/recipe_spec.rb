require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before :each do
    @user = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                     encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
    @user.skip_confirmation!
    @user.confirm
    @user.save
    @food = Food.create(name: 'foodstuff', measurement_unit: 'gr', price: 20, quantity: 1, user_id: @user.id)
    @recipe = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
                            public: true, user_id: @user.id)
    @recipefood = RecipeFood.create(quantity: 5, food_id: @food.id, recipe_id: @recipe.id)
  end

  it 'name should be present' do
    @recipe.name = nil
    expect(@recipe).to_not be_valid
  end

  it 'total_price should work' do
    expect(@recipe.total_price).to eq(100)
  end

  it 'total_items should work' do
    expect(@recipe.total_items).to eq(1)
  end
end
