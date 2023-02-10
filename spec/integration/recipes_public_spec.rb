require 'rails_helper'

RSpec.describe 'Recipes Public', type: :system do
  describe 'public' do
    before :all do
      @user = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                       encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user.skip_confirmation!
      @user.confirm
      @user.save
      sign_in @user
      @food1 = Food.create(name: 'foodstuff', measurement_unit: 'gr', price: 20, quantity: 1, user_id: @user.id)
      @recipe1 = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
        public: true, user_id: @user.id)
      @recipe2 = Recipe.create(name: 'privatefoodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
        public: false, user_id: @user.id)
      @recipe1food = RecipeFood.create(quantity: 5, food_id: @food1.id, recipe_id: @recipe1.id)
    end

    it 'displays the recipes' do
      visit public_recipes_path
      expect(page).to have_content('Recipes')
      expect(page).to have_content('foodrecipe')
      expect(page).to have_content("#{@recipe1.total_items}")
      expect(page).to have_content("#{@recipe1.total_price}")
      expect(page).to_not have_content('privatefoodrecipe')
    end

    after :all do
      @recipe1food.destroy
      @recipe1.destroy
      @recipe2.destroy
      @food1.destroy
      @user.destroy
    end
  end
end