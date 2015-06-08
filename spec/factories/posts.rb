FactoryGirl.define do
  factory :post do
    title { Faker::Name.title }
    body { Faker::Lorem.paragraph(5) }
    published false
    association :author, factory: :admin
    association :category, factory: :post_category
  end
end
