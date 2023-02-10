require 'rails_helper'

RSpec.describe 'Recipes', type: :feature do
  describe 'public' do
    before do
      user = create(:user)
      :only_path to true
    end
    it 'returns http success' do
    visit recipes_path
      expect(page).to have_http_status(:success)
    end

    it 'displays the recipes' do
      visit recipes_path
      expect(page).to have_content('Public Recipe')
    end
  end
end