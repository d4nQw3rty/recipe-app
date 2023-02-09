require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'GET recipes#index' do
    before(:each) do
      @user2 = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user2.skip_confirmation!
      @user2.confirm
      @user2.save
      @recipe2 = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
                               public: true, user_id: @user2.id)
      sign_in @user2
      get '/recipes'
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'includes text' do
      expect(response.body).to include(@recipe2.name.to_s)
    end
  end

  describe 'GET recipes#public' do
    before(:each) do
      @user2 = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user2.skip_confirmation!
      @user2.confirm
      @user2.save
      sign_in @user2
      @recipe2 = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
                               public: true, user_id: @user2.id)
      @privaterecipe = Recipe.create(name: 'privatefoodrecipe', preparation_time: '1.5', cooking_time: '1',
                                     description: 'lorem', public: false, user_id: @user2.id)
      get '/public_recipes'
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('public')
    end

    it 'includes text' do
      expect(response.body).to include(@recipe2.name.to_s)
      expect(response.body).to_not include(@privaterecipe.name.to_s)
    end
  end

  describe 'GET recipes#show' do
    before do
      @user2 = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user2.skip_confirmation!
      @user2.confirm
      @user2.save
      sign_in @user2
      @recipe2 = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
                               public: true, user_id: @user2.id)
      get "/recipes/#{@recipe2.id}"
    end
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('show')
    end

    it 'includes text' do
      expect(response.body).to include(@recipe2.name.to_s)
    end
  end

  describe 'GET recipes#new' do
    before(:each) do
      @user2 = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user2.skip_confirmation!
      @user2.confirm
      @user2.save
      sign_in @user2
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
    before(:each) do
      @user2 = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user2.skip_confirmation!
      @user2.confirm
      @user2.save
      sign_in @user2
      get '/recipes/new'
    end

    it 'creates a new recipe item' do
      post '/recipes',
           params: { recipe: { name: 'recipenameforrecipe', description: 'g', preparation_time: 6, cooking_time: 1,
                               public: false, user_id: @user2.id } }
      sign_in @user2
      get '/recipes'
      sign_in @user2
      expect(response.body).to include('recipenameforrecipe')
    end
  end

  describe 'DELETE recipes#destroy' do
    before(:each) do
      @user2 = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user2.skip_confirmation!
      @user2.confirm
      @user2.save
      sign_in @user2
      get '/recipes'
    end

    it 'deletes item' do
      recipe2 = Recipe.create(name: 'foodrecipe', preparation_time: '1.5', cooking_time: '1', description: 'lorem',
                              public: true, user_id: @user2.id)
      recipe2.save
      delete "/recipes/#{recipe2.id}/delete"
      expect(response.body).to_not include('foodrecipe')
    end
  end
end
