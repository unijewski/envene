require 'rails_helper'

describe 'Posts' do
  def visit_posts
    click_link 'Posts'
    within('li.active') do
      click_link 'List'
    end
  end

  before do
    Capybara.current_driver = :selenium
    @admin = FactoryGirl.create(:admin)
    @post = FactoryGirl.create(:post)
  end

  context 'when an admin displays all posts' do
    before do
      FactoryGirl.create(:post, title: 'Post title')
      sign_in_to_acp(@admin)
      visit_posts
    end

    it 'should see them' do
      expect(page).to have_content @post.title
      expect(page).to have_content 'Posts'
    end

    context 'and looks for posts by title' do
      it 'should see the result' do
        fill_in 'post_search', with: 'title'
        click_button 'Search'
        expect(page).to have_content 'Post title'
        expect(page).not_to have_content @post.title
      end
    end

    context 'and clicks "show"' do
      before do
        page.has_content? 'Show'
        first(:link, 'Show').click
      end

      it 'should see post details' do
        expect(page).to have_content @post.title
        expect(page).to have_content @post.body
      end

      context 'and clicks "back"' do
        it 'should see the list' do
          click_link 'Back'
          expect(page).to have_content @post.title
          expect(page).to have_content 'Posts'
        end
      end

      context 'and clicks "edit"' do
        it 'should be able to do changes' do
          click_link 'Edit'
          fill_in 'post_title', with: 'Edited post title'
          click_button 'Edit'
          expect(page).to have_content 'Edited post title'
        end
      end

      context 'and clicks "destroy"' do
        it 'should be able to delete the post' do
          click_link 'Destroy'
          page.driver.browser.switch_to.alert.accept
          expect(page).not_to have_content @post.title
        end
      end
    end

    context 'and clicks "edit"' do
      before { FactoryGirl.create(:post_category, name: 'Another category') }

      it 'should be able to change the post data' do
        page.has_content? 'Edit'
        first(:link, 'Edit').click
        fill_in 'post_title', with: 'Edited post title'
        fill_in 'wmd-input-body', with: 'Edited post body'
        select 'Another category', from: 'post_category_id'
        check('Published')
        click_button 'Edit'
        expect(page).to have_content 'Edited post title'
        expect(page).to have_content 'Another category'
        expect(page).to have_content 'Yes'
      end
    end

    context 'and clicks "destroy"' do
      it 'should be able to delete the post' do
        page.has_content? 'Destroy'
        first(:link, 'Destroy').click
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content @post.title
      end
    end
  end

  context 'when an admin clicks "add new"' do
    it 'should be able to create a new post' do
      sign_in_to_acp(@admin)
      click_link 'Posts'
      within('li.active') do
        click_link 'Add new'
      end
      fill_in 'post_title', with: 'New post title'
      fill_in 'wmd-input-body', with: 'New post body'
      select @post.category.name, from: 'post_category_id'
      click_button 'Create'
      expect(page).to have_content 'New post title'
      expect(page).to have_content 'New post body'
      expect(page).to have_content @post.category.name
      expect(page).to have_content 'No'
    end
  end
end
