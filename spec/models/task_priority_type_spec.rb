require 'rails_helper'

describe TaskPriorityType do
  let(:task_priority_type) { FactoryGirl.build(:task_priority_type) }

  it do
    should have_many(:tasks)
      .with_foreign_key('priority_id')
      .dependent(:destroy)
  end
  it { should validate_presence_of(:name) }
  it { should_not allow_value('!@#$%').for(:name) }

  it 'has a valid factory' do
    expect(task_priority_type).to be_valid
  end
end
