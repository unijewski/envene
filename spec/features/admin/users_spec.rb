require 'rails_helper'

describe 'Users' do
  def visit_users
    click_link 'Users'
    within('li.active') do
      click_link 'List'
    end
  end

  before do
    Capybara.current_driver = :selenium
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
  end

  context 'when an admin displays all users' do
    before do
      FactoryGirl.create(:user, username: 'User_name', email: 'email@example.com')
      sign_in_to_acp(@admin)
      visit_users
    end

    it 'should see them' do
      expect(page).to have_content @user.username
      expect(page).to have_content @user.email
      expect(page).to have_content @admin.username
      expect(page).to have_content @admin.email
      expect(page).to have_content 'Users'
    end

    context 'and looks for users' do
      context 'by name' do
        it 'should see the result' do
          fill_in 'user_search', with: 'name'
          click_button 'Search'
          expect(page).to have_content 'User_name'
          expect(page).to have_content 'email@example.com'
          expect(page).not_to have_content @user.username
        end
      end

      context 'by email' do
        it 'should see the result' do
          fill_in 'user_search', with: 'example.com'
          click_button 'Search'
          expect(page).to have_content 'User_name'
          expect(page).to have_content 'email@example.com'
          expect(page).not_to have_content @user.username
        end
      end
    end

    context 'and clicks "show"' do
      before do
        FactoryGirl.create(:post, author: @user)
        FactoryGirl.create(:task, author: @user)
        page.has_content? 'Show'
        first(:link, 'Show').click
      end

      it 'should see user details' do
        expect(page).to have_content @user.username
        expect(page).to have_content @user.email
        expect(page).to have_content 'Admin: No'
        expect(page).to have_content @user.posts.first.title
        expect(page).to have_content @user.tasks.first.name
      end

      context 'and clicks "back"' do
        it 'should see the list' do
          click_link 'Back'
          expect(page).to have_content @user.username
          expect(page).to have_content @admin.username
          expect(page).to have_content 'Users'
        end
      end

      context 'and clicks "edit"' do
        it 'should be able to do changes' do
          click_link 'Edit'
          fill_in 'user_username', with: 'Edited-user-name'
          click_button 'Edit'
          expect(page).to have_content 'Edited-user-name'
        end
      end

      context 'and clicks "destroy"' do
        it 'should be able to delete the user' do
          click_link 'Destroy'
          page.driver.browser.switch_to.alert.accept
          expect(page).not_to have_content @user.username
        end
      end
    end

    context 'and clicks "edit"' do
      before { FactoryGirl.create(:user_group, name: 'Moderator') }

      it 'should be able to change the user data' do
        page.has_content? 'Edit'
        first(:link, 'Edit').click
        fill_in 'user_username', with: 'Edited-user-name'
        fill_in 'user_email', with: 'edited@email.com'
        select 'Moderator', from: 'user_group_id'
        check('Admin')
        click_button 'Edit'
        expect(page).to have_content 'Edited-user-name'
        expect(page).to have_content 'edited@email.com'
      end
    end

    context 'and clicks "destroy"' do
      it 'should be able to delete the user' do
        page.has_content? 'Destroy'
        first(:link, 'Destroy').click
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content @user.username
      end
    end
  end

  context 'when an admin clicks "add new"' do
    it 'should be able to create a new user' do
      sign_in_to_acp(@admin)
      click_link 'Users'
      within('li.active') do
        click_link 'Add new'
      end
      fill_in 'user_username', with: 'New-user-username'
      fill_in 'user_email', with: 'new@email.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      select @user.group.name, from: 'user_group_id'
      click_button 'Create'
      expect(page).to have_content 'New-user-username'
      expect(page).to have_content 'new@email.com'
      expect(page).to have_content @user.group.name
      expect(page).to have_content 'Admin: No'
    end
  end

  context 'when an admin clicks "change your password"' do
    it 'should be able to change his password' do
      sign_in_to_acp(@admin)
      click_link 'Users'
      within('li.active') do
        click_link 'Change your password'
      end
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Change'
      expect(page).to have_content 'Dashboard'
      expect(page).to have_content "Welcome #{@admin.username}, love to see you back."
    end
  end
end
