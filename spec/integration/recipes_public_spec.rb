require 'rails_helper'

RSpec.describe 'Recipes', type: :system do
  describe 'public' do
    before do
      @user = User.new(name: 'nameofuser', email: 'asdt560@gmail.com', password: '6letters',
                       encrypted_password: '$2a$12$192AtELpNZ0aZCfnSxs35umQYmbSn52FK8ML/vY.iZvDW4FvkvHn2')
      @user.skip_confirmation!
      @user.confirm
      @user.save
      sign_in @user
    end

    it 'displays the recipes' do
      visit public_recipes_path
      expect(page).to have_content('Recipes')
    end
  end
end