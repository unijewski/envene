require 'rails_helper'

describe Post do
  let(:post) { FactoryGirl.build(:post) }

  it { should belong_to(:category).class_name('PostCategory') }
  it { should belong_to(:author).class_name('User') }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  it 'has a valid factory' do
    expect(post).to be_valid
  end

  describe '.search' do
    let(:post) { FactoryGirl.create(:post, title: 'post title') }

    it 'should find the post by title' do
      expect(Post.search('title')).to include post
    end

    it 'should not find any posts' do
      expect(Post.search(Faker::Lorem.word)).not_to include post
    end
  end
end
