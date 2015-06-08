require 'rails_helper'

describe UserGroup do
  let(:user_group) { FactoryGirl.build(:user_group) }

  it do
    should have_many(:users)
      .with_foreign_key('group_id')
      .dependent(:destroy)
  end
  it { should validate_presence_of(:name) }
  it { should_not allow_value('!@#$%').for(:name) }

  it 'has a valid factory' do
    expect(user_group).to be_valid
  end
end
