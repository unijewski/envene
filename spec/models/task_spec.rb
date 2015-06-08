require 'rails_helper'

describe Task do
  let(:task) { FactoryGirl.build(:task) }

  it { should belong_to(:status).class_name('TaskStatus') }
  it { should belong_to(:priority).class_name('TaskPriorityType') }
  it { should belong_to(:author).class_name('User') }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it do
    should validate_numericality_of(:progress)
      .is_greater_than_or_equal_to(0)
      .is_less_than_or_equal_to(100)
  end

  it 'has a valid factory' do
    expect(task).to be_valid
  end

  describe '.search' do
    let(:task) { FactoryGirl.create(:task, name: 'task name') }

    it 'should find the task by task name' do
      expect(Task.search('name')).to include task
    end

    it 'should not find any tasks' do
      expect(Task.search(Faker::Lorem.word)).not_to include task
    end
  end
end
