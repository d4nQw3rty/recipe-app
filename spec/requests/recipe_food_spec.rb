require 'rails_helper'

RSpec.describe 'Recipefoods', type: :request do
  describe 'GET recipe_foods#new' do
    before do
      @user = User.first
      @user.confirm
      @recipe = Recipe.where(user_id: @user.id).last
      sign_in @user
      get "/recipes/#{@recipe.id}/new_ingredient"
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
      @user = User.first
      @user.confirm
      @recipe = Recipe.where(user_id: @user.id).last
      @recipefood
      sign_in @user
      get "/recipes/#{@recipe.id}/shopping_list"
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
      @user = User.first
      @user.confirm
      @recipe = Recipe.where(user_id: @user.id).last
      @food = Food.where(user_id: @user.id).last
      sign_in @user
      get "/recipes/#{@recipe.id}/new_ingredient"
    end

    it 'creates a new recipe item' do
      post "/recipes/#{@recipe.id}",
           params: { recipe: { quantity: 1, recipe_id: @recipe.id, food_id: @food.id } }
      expect(response).to redirect_to("/recipes/#{@recipe.id}")
      get "/recipes/#{@recipe.id}"
      expect(response.body).to include(@food.name.to_s)
    end
  end

  describe 'GET recipe_foods#edit' do
    before do
      @user = User.first
      @user.confirm
      @recipe = Recipe.where(user_id: @user.id).last
      @food = Food.where(user_id: @user.id).last
      @recipefood = RecipeFood.where(recipe_id: @recipe.id).last
      sign_in @user
      get "/recipes/#{@recipe.id}/update/#{@recipefood.id}"
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
      @user = User.first
      @user.confirm
      @recipe = Recipe.where(user_id: @user.id).last
      @food = Food.where(user_id: @user.id).last
      @recipefood = RecipeFood.where(recipe_id: @recipe.id).last
      sign_in @user
      get "/recipes/#{@recipe.id}/update/#{@recipefood.id}"
    end
    it 'updates a new recipefood item' do
      put "/recipes/#{@recipe.id}/update/#{@recipefood.id}", params: { recipe: { quantity: 535_311 } }
      expect(response).to redirect_to("/recipes/#{@recipe.id}")
      get "/recipes/#{@recipe.id}"
      expect(response.body).to include(@recipefood.quantity.to_s)
    end
  end

  describe 'DELETE recipe_foods#destroy' do
    before do
      @user = User.first
      @user.confirm
      @recipe = Recipe.where(user_id: @user.id).last
      @food = Food.where(user_id: @user.id).last
      @recipefood = RecipeFood.where(recipe_id: @recipe.id).last
      sign_in @user
      get "/recipes/#{@recipe.id}/new_ingredient"
    end

    it 'deletes item' do
      post "/recipes/#{@recipe.id}",
           params: { recipe: { quantity: 1, recipe_id: @recipe.id, food_id: @food.id } }
      expect(response).to redirect_to("/recipes/#{@recipe.id}")
      get "/recipes/#{@recipe.id}"
      expect(response.body).to include(@recipefood.food.name.to_s)
      delete "/recipes/#{@recipe.id}/delete/#{@recipefood.id}"
      expect(response.body).to_not include(@recipefood.food.name.to_s)
    end
  end
end
