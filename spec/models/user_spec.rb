require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  it { should belong_to(:group).class_name('UserGroup') }
  it do
    should have_many(:tasks)
      .with_foreign_key('author_id')
      .dependent(:destroy)
  end
  it do
    should have_many(:posts)
      .with_foreign_key('author_id')
      .dependent(:destroy)
  end
  it { should validate_presence_of(:username) }
  it { should_not allow_value('!@#$%').for(:username) }
  it { should validate_uniqueness_of(:username).case_insensitive }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  describe '.search' do
    let(:user) { FactoryGirl.create(:user, email: 'user@example.com') }
    let(:user2) { FactoryGirl.create(:user, username: 'user_name') }

    it 'should find the user by email' do
      expect(User.search('example')).to include user
    end

    it 'should find the user by username' do
      expect(User.search('name')).to include user2
    end

    it 'should find the both users' do
      expect(User.search('user')).to include user, user2
    end

    it 'should not find any users' do
      expect(User.search(Faker::Lorem.word)).not_to include user, user2
    end
  end
end
