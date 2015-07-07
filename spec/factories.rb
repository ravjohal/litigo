# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "#{Faker::Lorem.characters(8)}-#{n}@factory.com"
  end

  factory :contact do
    first_name "#{Faker::Lorem.characters(8)}"
    last_name "#{Faker::Lorem.characters(8)}"
    type "#{Faker::Lorem.characters(8)}"
  end

  factory :contact_similar, class: Contact do
    first_name "#{Faker::Lorem.characters(8)}"
    last_name "#{Faker::Lorem.characters(8)}"
    type "#{Faker::Lorem.characters(8)}"
  end

  factory :contact_another, class: Contact do
    first_name "#{Faker::Lorem.characters(10)}"
    last_name "#{Faker::Lorem.characters(10)}"
    type "#{Faker::Lorem.characters(8)}"
  end

  factory :attorney do
    attorney_type "#{Faker::Lorem.characters(8)}"
    first_name "#{Faker::Lorem.characters(8)}"
    last_name "#{Faker::Lorem.characters(8)}"
  end

  factory :event do

  end

  factory :document do

  end

  factory :firm do
    name "#{Faker::Lorem.characters(8)}"
    phone "#{Faker::Number.number(10)}"
    fax "#{Faker::Number.number(10)}"
    zip "#{Faker::Lorem.characters(8)}"
    tenant "#{Faker::Lorem.characters(8)}"
  end

  factory :user do
    email
    first_name "1#{Faker::Lorem.characters(7)}"
    last_name "1#{Faker::Lorem.characters(7)}"
    password "1#{Faker::Lorem.characters(7)}"
  end

  factory :case do
    case_number "#{Random.rand(5)}"
    case_type "case type #{Faker::Lorem.characters(7)}"
    subtype "subtype #{Faker::Lorem.characters(7)}"
    name "#{Faker::Lorem.characters(8)}"
    description "#{Faker::Lorem.words(Random.rand(10)).join(" ")}"
  end

  factory :case_with_incident, parent: :case do
    after(:create) do |incident_case|
      FactoryGirl.create(:incident, case: incident_case)
    end
  end

  factory :incident do
    incident_date Date.today
    defendant_liability Random.rand(100)
    alcohol_involved [true, false].sample
    weather_factor [true, false].sample
    airbag_deployed [true, false].sample
    speed "20"
  end

  factory :client do
    first_name "#{Faker::Lorem.characters(8)}"
    last_name "#{Faker::Lorem.characters(8)}"
  end

  factory :defendant do
    first_name "#{Faker::Lorem.characters(8)}"
    last_name "#{Faker::Lorem.characters(8)}"
  end

  factory :note do

  end

  factory :plantiff do

  end

  factory :task do

  end

  factory :witness do
    first_name "#{Faker::Lorem.characters(8)}"
    last_name "#{Faker::Lorem.characters(8)}"
  end

end
