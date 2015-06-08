FactoryGirl.define do
  factory :user_group do
    name { Faker::Lorem.word }
  end
end
