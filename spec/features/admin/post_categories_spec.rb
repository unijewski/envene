require 'rails_helper'

describe 'Post categories' do
  def visit_post_categories
    click_link 'Posts'
    click_link 'Categories'
    within('li.active li.active') do
      click_link 'List'
    end
  end

  before do
    Capybara.current_driver = :selenium
    @admin = FactoryGirl.create(:admin)
    @post_category = FactoryGirl.create(:post_category)
    FactoryGirl.create(:post, category: @post_category)
  end

  context 'when an admin displays all post categories' do
    before do
      sign_in_to_acp(@admin)
      visit_post_categories
    end

    it 'should see them' do
      expect(page).to have_content @post_category.name
      expect(page).to have_content 'Post categories'
    end

    context 'and clicks "show"' do
      it 'should see posts assigned to this category' do
        page.has_content? 'Show'
        first(:link, 'Show').click
        expect(page).to have_content @post_category.posts.first.title
      end
    end

    context 'and clicks "edit"' do
      it 'should be able to change the category name' do
        page.has_content? 'Edit'
        first(:link, 'Edit').click
        fill_in 'post_category_name', with: 'Edited category name'
        click_button 'Edit'
        expect(page).to have_content 'Edited category name'
      end
    end

    context 'and clicks "destroy"' do
      it 'should be able to delete the category' do
        page.has_content? 'Destroy'
        first(:link, 'Destroy').click
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content @post_category.posts.first.title
      end
    end
  end

  context 'when an admin clicks "add new"' do
    it 'should be able to create a new post category' do
      sign_in_to_acp(@admin)
      click_link 'Posts'
      click_link 'Categories'
      within('li.active li.active') do
        click_link 'Add new'
      end
      fill_in 'post_category_name', with: 'New category name'
      click_button 'Create'
      expect(page).to have_content 'New category name'
    end
  end
end
