require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  describe 'GET foods#index' do
    before do
      user = User.first
      user.confirm
      sign_in user
      get '/foods'
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'includes text' do
      expect(response.body).to include('<a href="/foods/new">Add food</a>')
    end
  end

  describe 'GET foods#new' do
    before do
      user = User.first
      user.confirm
      sign_in user
      get '/foods/new'
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('new')
    end

    it 'includes text' do
      expect(response.body).to include('<form action="/foods" accept-charset="UTF-8" method="post">')
    end
  end

  describe 'POST foods#create' do
    before do
      user = User.first
      user.confirm
      sign_in user
      get '/foods/new'
    end
    it 'creates a new food item' do
      post '/foods',
           params: { food: { name: 'foodnameforname', measurement_unit: 'g', price: 6, quantity: 1 } }
      expect(response).to redirect_to('/foods')
      get '/foods'
      expect(response.body).to include('foodnameforname')
    end
  end

  describe 'DELETE foods#destroy' do
    before do
      @user = User.first
      @user.confirm
      sign_in @user
      get '/foods/new'
    end

    it 'deletes item' do
      post '/foods',
           params: { food: { name: 'foodnameforname', measurement_unit: 'g', price: 6, quantity: 1 } }
      get '/foods'
      food = Food.where(user_id: @user.id).last
      delete "/foods/#{food.id}"
      expect(response.body).to_not include('foodnameforname')
    end
  end
end
