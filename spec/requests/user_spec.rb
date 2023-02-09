require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET users#index' do
    it 'is a success' do
      user = User.first
      user.confirm
      sign_in user
      get '/users'
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      user = User.first
      user.confirm
      sign_in user
      get '/users'
      expect(response).to render_template('index')
    end

    it 'includes text' do
      user = User.first
      user.confirm
      sign_in user
      get '/users'
      expect(response.body).to include('<h1>Users</h1>')
    end
  end
  describe 'GET users#show' do
    it 'is a success' do
      user = User.first
      user.confirm
      sign_in user
      get "/users/#{user.id}"
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      user = User.first
      user.confirm
      sign_in user
      get "/users/#{user.id}"
      expect(response).to render_template('show')
    end

    it 'includes placeholder text' do
      user = User.first
      user.confirm
      sign_in user
      get "/users/#{user.id}"
      expect(response.body).to include('Back to users')
    end
  end
end