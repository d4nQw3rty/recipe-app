require 'rails_helper'

RSpec.describe 'Foods', type: :system do
  describe 'new' do
    before :all do
      @user = User.new(name: 'nameofuser', email: 'asdt5602@gmail.com', password: '6letters',
                       encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user.skip_confirmation!
      @user.confirm
      @user.save
      @food = Food.create(name: 'foodstuff', measurement_unit: 'gr', price: 20, quantity: 1, user_id: @user.id)
      @recipe = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
                              public: true, user_id: @user.id)
      @recipefood = RecipeFood.create(quantity: 5, food_id: @food.id, recipe_id: @recipe.id)
      sign_in @user
    end
    it 'displays the following features' do
      visit new_food_path
      expect(page).to have_content(@user.name) # 1
      expect(page).to have_content('Name') # 2
      expect(page).to have_content('Measurement unit') # 3
      expect(page).to have_content('Price') # 4
      expect(page).to have_content('Quantity') # 5
    end
    after :all do
      @recipefood.destroy
      @recipe.destroy
      @food.destroy
      @user.destroy
    end
  end
end
