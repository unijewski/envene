require 'rails_helper'

describe 'Static pages' do
  before do
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
  end

  context 'when a not logged user visits admin path' do
    it 'should see the error page' do
      visit admin_dashboard_path(locale: 'en')
      expect(page).to have_content 'Permission denied'
      expect(page).to have_content 'Sorry, but it looks that you do not have permissions to see this site.'
    end
  end

  context 'when an user signs in and visits admin panel' do
    it 'should see the error page' do
      sign_in_to_acp(@user)
      expect(page).to have_content 'Permission denied'
      expect(page).to have_content 'Sorry, but it looks that you do not have permissions to see this site.'
    end
  end

  context 'when an admin signs in and visits admin panel' do
    it 'should see the dashboard' do
      sign_in_to_acp(@admin)
      expect(page).to have_content 'Envene'
      expect(page).to have_content 'Dashboard'
      expect(page).to have_content "Welcome #{@admin.username}, love to see you back."
      expect(page).to have_css('a.active-menu', text: 'Dashboard')
    end
  end
end
