require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before :each do
    @user5 = User.new(name: 'nameofuser', email: 'asdt5605@gmail.com', password: '6letters',
                     encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
    @user5.skip_confirmation!
    @user5.confirm
    @user5.save
    @food5 = Food.create(name: 'foodstuff', measurement_unit: 'gr', price: 20, quantity: 1, user_id: @user5.id)
    @recipe5 = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
                            public: true, user_id: @user5.id)
    @recipe5food = RecipeFood.create(quantity: 5, food_id: @food5.id, recipe_id: @recipe5.id)
  end

  it 'name should be present' do
    @recipe5.name = nil
    expect(@recipe5).to_not be_valid
  end

  it 'total_price should work' do
    expect(@recipe5.total_price).to eq(100)
  end

  it 'total_items should work' do
    expect(@recipe5.total_items).to eq(1)
  end
end
