require 'rails_helper'

describe 'Task statuses' do
  def visit_task_statuses
    click_link 'Task'
    click_link 'Statuses'
    within('li.active li.active') do
      click_link 'List'
    end
  end

  before do
    Capybara.current_driver = :selenium
    @admin = FactoryGirl.create(:admin)
    @task_status = FactoryGirl.create(:task_status)
    FactoryGirl.create(:task, status: @task_status)
  end

  context 'when an admin displays all task statuses' do
    before do
      sign_in_to_acp(@admin)
      visit_task_statuses
    end

    it 'should see them' do
      expect(page).to have_content @task_status.name
      expect(page).to have_content 'Task statuses'
    end

    context 'and clicks "show"' do
      it 'should see tasks assigned to this status' do
        page.has_content? 'Show'
        first(:link, 'Show').click
        expect(page).to have_content @task_status.tasks.first.name
      end
    end

    context 'and clicks "edit"' do
      it 'should be able to change the status name' do
        page.has_content? 'Edit'
        first(:link, 'Edit').click
        fill_in 'task_status_name', with: 'Edited status name'
        click_button 'Edit'
        expect(page).to have_content 'Edited status name'
      end
    end

    context 'and clicks "destroy"' do
      it 'should be able to delete the status' do
        page.has_content? 'Destroy'
        first(:link, 'Destroy').click
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content @task_status.name
      end
    end
  end

  context 'when an admin clicks "add new"' do
    it 'should be able to create a new task status' do
      sign_in_to_acp(@admin)
      click_link 'Task'
      click_link 'Statuses'
      within('li.active li.active') do
        click_link 'Add new'
      end
      fill_in 'task_status_name', with: 'New status name'
      click_button 'Create'
      expect(page).to have_content 'New status name'
    end
  end
end
