FactoryGirl.define do
  factory :task_status do
    name { Faker::Lorem.word }
  end
end
