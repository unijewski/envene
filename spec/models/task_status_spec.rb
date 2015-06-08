require 'rails_helper'

describe TaskStatus do
  let(:task_status) { FactoryGirl.build(:task_status) }

  it do
    should have_many(:tasks)
      .with_foreign_key('status_id')
      .dependent(:destroy)
  end
  it { should validate_presence_of(:name) }
  it { should_not allow_value('!@#$%').for(:name) }

  it 'has a valid factory' do
    expect(task_status).to be_valid
  end
end
