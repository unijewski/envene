FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }
    admin false
    username { Faker::Internet.user_name }
    association :group, factory: :user_group
  end

  factory :admin, class: User do
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }
    admin true
    username { Faker::Internet.user_name }
    association :group, factory: :user_group
  end
end
