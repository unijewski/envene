require 'rails_helper'

describe 'Task priority types' do
  def visit_task_priority_types
    click_link 'Task'
    click_link 'Priority types'
    within('li.active li.active') do
      click_link 'List'
    end
  end

  before do
    Capybara.current_driver = :selenium
    @admin = FactoryGirl.create(:admin)
    @task_priority_type = FactoryGirl.create(:task_priority_type)
    FactoryGirl.create(:task, priority: @task_priority_type)
  end

  context 'when an admin displays all task priority types' do
    before do
      sign_in_to_acp(@admin)
      visit_task_priority_types
    end

    it 'should see them' do
      expect(page).to have_content @task_priority_type.name
      expect(page).to have_content 'Task priority types'
    end

    context 'and clicks "show"' do
      it 'should see tasks assigned to this priority type' do
        page.has_content? 'Show'
        first(:link, 'Show').click
        expect(page).to have_content @task_priority_type.tasks.first.name
      end
    end

    context 'and clicks "edit"' do
      it 'should be able to change the priority type name' do
        page.has_content? 'Edit'
        first(:link, 'Edit').click
        fill_in 'task_priority_type_name', with: 'Edited priority type name'
        click_button 'Edit'
        expect(page).to have_content 'Edited priority type name'
      end
    end

    context 'and clicks "destroy"' do
      it 'should be able to delete the priority type' do
        page.has_content? 'Destroy'
        first(:link, 'Destroy').click
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content @task_priority_type.name
      end
    end
  end

  context 'when an admin clicks "add new"' do
    it 'should be able to create a new task priority type' do
      sign_in_to_acp(@admin)
      click_link 'Task'
      click_link 'Priority types'
      within('li.active li.active') do
        click_link 'Add new'
      end
      fill_in 'task_priority_type_name', with: 'New priority type name'
      click_button 'Create'
      expect(page).to have_content 'New priority type name'
    end
  end
end
