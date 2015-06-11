require 'rails_helper'

describe 'Tasks' do
  def visit_tasks
    click_link 'Tasks'
    within('li.active') do
      click_link 'List'
    end
  end

  before do
    Capybara.current_driver = :selenium
    @admin = FactoryGirl.create(:admin)
    @task = FactoryGirl.create(:task)
  end

  context 'when an admin displays all tasks' do
    before do
      FactoryGirl.create(:task, name: 'Task name')
      sign_in_to_acp(@admin)
      visit_tasks
    end

    it 'should see them' do
      expect(page).to have_content @task.name
      expect(page).to have_content 'Tasks'
    end

    context 'and looks for tasks by name' do
      it 'should see the result' do
        fill_in 'task_search', with: 'name'
        click_button 'Search'
        expect(page).to have_content 'Task name'
        expect(page).not_to have_content @task.name
      end
    end

    context 'and clicks "show"' do
      before do
        page.has_content? 'Show'
        first(:link, 'Show').click
      end

      it 'should see task details' do
        expect(page).to have_content @task.name
        expect(page).to have_content @task.description
      end

      context 'and clicks "back"' do
        it 'should see the list' do
          click_link 'Back'
          expect(page).to have_content @task.name
          expect(page).to have_content 'Tasks'
        end
      end

      context 'and clicks "edit"' do
        it 'should be able to do changes' do
          click_link 'Edit'
          fill_in 'task_name', with: 'Edited task name'
          click_button 'Edit'
          expect(page).to have_content 'Edited task name'
        end
      end

      context 'and clicks "destroy"' do
        it 'should be able to delete the task' do
          click_link 'Destroy'
          page.driver.browser.switch_to.alert.accept
          expect(page).not_to have_content @task.name
        end
      end
    end

    context 'and clicks "edit"' do
      before do
        FactoryGirl.create(:task_priority_type, name: 'High')
        FactoryGirl.create(:task_status, name: 'Urgent')
      end

      it 'should be able to change the task data' do
        page.has_content? 'Edit'
        first(:link, 'Edit').click
        fill_in 'task_name', with: 'Edited task name'
        fill_in 'wmd-input-description', with: 'Edited task description'
        select 'High', from: 'task_priority_id'
        select 'Urgent', from: 'task_status_id'
        click_button 'Edit'
        expect(page).to have_content 'Edited task name'
        expect(page).to have_content 'High'
        expect(page).to have_content 'Urgent'
      end
    end

    context 'and clicks "destroy"' do
      it 'should be able to delete the task' do
        page.has_content? 'Destroy'
        first(:link, 'Destroy').click
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content @task.name
      end
    end
  end

  context 'when an admin clicks "add new"' do
    it 'should be able to create a new task' do
      sign_in_to_acp(@admin)
      click_link 'Tasks'
      within('li.active') do
        click_link 'Add new'
      end
      fill_in 'task_name', with: 'New task name'
      fill_in 'wmd-input-description', with: 'New task description'
      select @task.priority.name, from: 'task_priority_id'
      select @task.status.name, from: 'task_status_id'
      click_button 'Create'
      expect(page).to have_content 'New task name'
      expect(page).to have_content 'New task description'
      expect(page).to have_content @task.priority.name
      expect(page).to have_content @task.status.name
    end
  end
end
