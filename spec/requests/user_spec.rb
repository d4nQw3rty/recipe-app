require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET users#index' do
    before(:each) do
      @user3 = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user3.skip_confirmation!
      @user3.confirm
      @user3.save
      sign_in @user3
      get '/users'
    end
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'includes text' do
      expect(response.body).to include('<h1>Users</h1>')
    end
  end
  describe 'GET users#show' do
    before(:each) do
      @user3 = User.new(name: 'nameofuser', email: 'asdt560zzz@gmail.com', password: '6letters',
                        encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user3.skip_confirmation!
      @user3.confirm
      @user3.save
      sign_in @user3
      get "/users/#{@user3.id}"
    end
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it 'includes placeholder text' do
      expect(response.body).to include('nameofuser')
    end
  end
end
