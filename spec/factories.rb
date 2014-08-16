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
    attorney_type "#{Faker::Lorem.characters(8)}"
    firm "#{Faker::Lorem.characters(8)}"
  end

  factory :event do

  end

  factory :document do

  end

  factory :user do
    email
    password "1#{Faker::Lorem.characters(7)}"
  end

  factory :case do
    number Random.rand(5)
    case_type :some_case_type
    subtype :some_subtype
    name "#{Faker::Lorem.characters(8)}"
    description "#{Faker::Lorem.words(Random.rand(10)).join(" ")}"
  end

  factory :client do

  end

  factory :defendant do

  end

  factory :note do

  end

  factory :plantiff do

  end

  factory :task do

  end

  factory :witness do

  end

end
