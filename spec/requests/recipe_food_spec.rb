require 'rails_helper'

RSpec.describe 'Recipefoods', type: :request do
  describe 'GET recipe_foods#new' do
    before do
      @user1 = User.new(name: 'nameofuser', email: 'asdt560aaa@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user1.skip_confirmation!
      @user1.confirm
      @user1.save
      @food1 = Food.create(name: 'foodstuff', measurement_unit: 'gr', price: 20, quantity: 1, user_id: @user1.id)
      @recipe1 = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
                               public: true, user_id: @user1.id)
      @recipe1food = RecipeFood.create(quantity: 5, food_id: @food1.id, recipe_id: @recipe1.id)
      sign_in @user1
      get "/recipes/#{@recipe1.id}/new_ingredient"
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('new')
    end

    it 'includes text' do
      expect(response.body).to include('New Ingredient')
    end
  end

  describe 'GET recipe_foods#shopping_list' do
    before do
      @user1 = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user1.skip_confirmation!
      @user1.confirm
      @user1.save
      @food1 = Food.create(name: 'foodstuff', measurement_unit: 'gr', price: 20, quantity: 1, user_id: @user1.id)
      @recipe1 = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
                               public: true, user_id: @user1.id)
      @recipe1food = RecipeFood.create(quantity: 5, food_id: @food1.id, recipe_id: @recipe1.id)
      sign_in @user1
      get "/recipes/#{@recipe1.id}/shopping_list"
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('shopping_list')
    end

    it 'includes text' do
      expect(response.body).to include('Shopping list')
    end
  end

  describe 'POST recipe_foods#create' do
    before do
      @user1 = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user1.skip_confirmation!
      @user1.confirm
      @user1.save
      @food1 = Food.create(name: 'foodstuff', measurement_unit: 'gr', price: 20, quantity: 1, user_id: @user1.id)
      @recipe1 = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
                               public: true, user_id: @user1.id)
      @recipe1food = RecipeFood.create(quantity: 5, food_id: @food1.id, recipe_id: @recipe1.id)
      sign_in @user1
      get "/recipes/#{@recipe1.id}/new_ingredient"
    end

    it 'creates a new recipe item' do
      post "/recipes/#{@recipe1.id}",
           params: { recipe_food: { quantity: 1, recipe_id: @recipe1.id, food_id: @food1.id } }
      expect(response).to redirect_to("/recipes/#{@recipe1.id}")
      get "/recipes/#{@recipe1.id}"
      expect(response.body).to include(@food1.name.to_s)
    end
  end

  describe 'GET recipe_foods#edit' do
    before do
      @user1 = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user1.skip_confirmation!
      @user1.confirm
      @user1.save
      @food1 = Food.create(name: 'foodstuff', measurement_unit: 'gr', price: 20, quantity: 1, user_id: @user1.id)
      @recipe1 = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
                               public: true, user_id: @user1.id)
      @recipe1food = RecipeFood.create(quantity: 5, food_id: @food1.id, recipe_id: @recipe1.id)
      sign_in @user1
      get "/recipes/#{@recipe1.id}/update/#{@recipe1food.id}"
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('edit')
    end

    it 'includes text' do
      expect(response.body).to include('Update Ingredient')
    end
  end

  describe 'PUT recipe_foods#update' do
    before do
      @user1 = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user1.skip_confirmation!
      @user1.confirm
      @user1.save
      @food1 = Food.create(name: 'foodstuff', measurement_unit: 'gr', price: 20, quantity: 1, user_id: @user1.id)
      @recipe1 = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
                               public: true, user_id: @user1.id)
      @recipe1food = RecipeFood.create(quantity: 5, food_id: @food1.id, recipe_id: @recipe1.id)
      sign_in @user1
      get "/recipes/#{@recipe1.id}/update/#{@recipe1food.id}"
    end
    it 'updates a new recipefood item' do
      put "/recipes/#{@recipe1.id}/update/#{@recipe1food.id}", params: { recipe_food: { quantity: 535_311 } }
      expect(response).to redirect_to("/recipes/#{@recipe1.id}")
      get "/recipes/#{@recipe1.id}"
      expect(response.body).to include(@recipe1food.quantity.to_s)
    end
  end

  describe 'DELETE recipe_foods#destroy' do
    before do
      @user1 = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user1.skip_confirmation!
      @user1.confirm
      @user1.save
      @food1 = Food.create(name: 'foodstuff', measurement_unit: 'gr', price: 20, quantity: 1, user_id: @user1.id)
      @recipe1 = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
                               public: true, user_id: @user1.id)
      @recipe1food = RecipeFood.create(quantity: 5, food_id: @food1.id, recipe_id: @recipe1.id)
      sign_in @user1
      get "/recipes/#{@recipe1.id}/new_ingredient"
    end

    it 'deletes item' do
      post "/recipes/#{@recipe1.id}",
           params: { recipe_food: { quantity: 1, recipe_id: @recipe1.id, food_id: @food1.id } }
      expect(response).to redirect_to("/recipes/#{@recipe1.id}")
      get "/recipes/#{@recipe1.id}"
      expect(response.body).to include(@recipe1food.food.name.to_s)
      delete "/recipes/#{@recipe1.id}/delete/#{@recipe1food.id}"
      expect(response.body).to_not include(@recipe1food.food.name.to_s)
    end
  end
end
