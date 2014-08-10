# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "#{Faker::Lorem.characters(8)}-#{n}@factory.com"
  end

  factory :contact do
    first_name "#{Faker::Lorem.characters(8)}"
    last_name "#{Faker::Lorem.characters(8)}"
  end

  factory :attorney do
    attorney_type "#{Faker::Lorem.words(Random.rand(10)).join(" ")}"
    firm "#{Faker::Lorem.words(Random.rand(10)).join(" ")}"
  end

  factory :event do

  end


end
