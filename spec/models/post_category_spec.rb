require 'rails_helper'

describe PostCategory do
  let(:post_category) { FactoryGirl.build(:post_category) }

  it do
    should have_many(:posts)
      .with_foreign_key('category_id')
      .dependent(:destroy)
  end
  it { should validate_presence_of(:name) }
  it { should_not allow_value('!@#$%').for(:name) }

  it 'has a valid factory' do
    expect(post_category).to be_valid
  end
end
