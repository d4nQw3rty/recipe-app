require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before :each do
    @user2 = User.new(name: 'nameofuser2', email: 'asdt56013@gmail.com', password: '6letters',
                      encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
    @user2.skip_confirmation!
    @user2.confirm
    @user2.save
    @food2 = Food.create(name: 'foodstuff2', measurement_unit: 'gr', price: 20, quantity: 1, user_id: @user2.id)
    @recipe2 = Recipe.create(name: 'foodrecipe2', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
                             public: true, user_id: @user2.id)
    @recipefood2 = RecipeFood.create(quantity: 5, food_id: @food2.id, recipe_id: @recipe2.id)
  end
  it 'quantity should not be smaller than 1' do
    @recipefood2.quantity = 0
    expect(@recipefood2).to_not be_valid
  end
end
