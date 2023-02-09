require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'GET recipes#index' do
    before do
      user = User.first
      user.confirm
      sign_in user
      get '/recipes'
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'includes text' do
      expect(response.body).to include('foodrecipe')
    end
  end

  describe 'GET recipes#public' do
    before do
      user = User.first
      user.confirm
      sign_in user
      get '/public_recipes'
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('public')
    end

    it 'includes text' do
      expect(response.body).to include('foodrecipe')
      expect(response.body).to_not include('privatefoodrecipe')
    end
  end

  describe 'GET recipes#show' do
    before do
      user = User.first
      user.confirm
      sign_in user
      @recipe = Recipe.where(user_id: user.id).last
      get "/recipes/#{@recipe.id}"
    end
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('show')
    end

    it 'includes text' do
      expect(response.body).to include(@recipe.name.to_s)
    end
  end

  describe 'GET recipes#new' do
    before do
      user = User.first
      user.confirm
      sign_in user
      get '/recipes/new'
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('new')
    end

    it 'includes text' do
      expect(response.body).to include('<form action="/recipes" accept-charset="UTF-8" method="post">')
    end
  end

  describe 'POST recipes#create' do
    before do
      user = User.first
      user.confirm
      sign_in user
      get '/recipes/new'
    end

    it 'creates a new recipe item' do
      post '/recipes',
           params: { recipe: { name: 'recipenameforrecipe', description: 'g', preparation_time: 6, cooking_time: 1,
                               public: false } }
      expect(response).to redirect_to('/recipes')
      get '/recipes'
      expect(response.body).to include('recipenameforrecipe')
    end
  end

  describe 'DELETE recipes#destroy' do
    before do
      @user = User.first
      @user.confirm
      sign_in @user
      get '/recipes/new'
    end

    it 'deletes item' do
      post '/recipes',
           params: { recipe: { name: 'recipenameforrecipe', description: 'g', preparation_time: 6, cooking_time: 1,
                               public: false } }
      get '/recipes'
      recipe = Recipe.where(user_id: @user.id).last
      delete "/recipes/#{recipe.id}/delete"
      expect(response.body).to_not include('recipenameforrecipe')
    end
  end
end
