FactoryGirl.define do
  factory :task do
    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(5) }
    progress 0
    association :status, factory: :task_status
    association :priority, factory: :task_priority_type
    association :author, factory: :admin
  end
end
