require 'rails_helper'

describe 'User groups' do
  def visit_user_groups
    click_link 'Users'
    click_link 'Groups'
    within('li.active li.active') do
      click_link 'List'
    end
  end

  before do
    Capybara.current_driver = :selenium
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
    @user_group = FactoryGirl.create(:user_group)
  end

  context 'when an admin displays all user groups' do
    before do
      sign_in_to_acp(@admin)
      visit_user_groups
    end

    it 'should see them' do
      expect(page).to have_content @user_group.name
      expect(page).to have_content 'User groups'
    end

    context 'and clicks "show"' do
      it 'should see users assigned to this group' do
        page.has_content? 'Show'
        first(:link, 'Show').click
        expect(page).to have_content @user.email
        expect(page).to have_content @user.username
      end
    end

    context 'and clicks "edit"' do
      it 'should be able to change the group name' do
        page.has_content? 'Edit'
        first(:link, 'Edit').click
        fill_in 'user_group_name', with: 'Edited group name'
        click_button 'Edit'
        expect(page).to have_content 'Edited group name'
      end
    end

    context 'and clicks "destroy"' do
      it 'should be able to delete the group' do
        page.has_content? 'Destroy'
        first(:link, 'Destroy').click
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content @user_group.name
      end
    end
  end

  context 'when an admin clicks "add new"' do
    it 'should be able to create a new user group' do
      sign_in_to_acp(@admin)
      click_link 'Users'
      click_link 'Groups'
      within('li.active li.active') do
        click_link 'Add new'
      end
      fill_in 'user_group_name', with: 'New group name'
      click_button 'Create'
      expect(page).to have_content 'New group name'
    end
  end
end
