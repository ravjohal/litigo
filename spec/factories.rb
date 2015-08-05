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

  factory :namespace do
    namespace_id "#{Faker::Lorem.characters(32)}"
    account_id "#{Faker::Lorem.characters(32)}"
    email_address "#{Faker::Lorem.characters(8)}-@factory.com"
    name "#{Faker::Lorem.characters(8)}"
    provider 'factory'
    account_status 'active'
    factory :default_namespace do
      namespace_id 'angjx1hjrostsm309j3ti44m1'
      account_id 'mdyvil9u4ndniu5s5hqhiz0x'
      email_address 'litigo1test@gmail.com'
      name 'Test Test'
      provider 'gmail'
      inbox_token '3vP0XYtecGCTy2jEJdcgsE5GnKy9be'
      account_status 'active'
    end
  end

  factory :calendar do
    description "#{Faker::Lorem.characters(20)}"
    calendar_id "#{Faker::Lorem.characters(32)}"
    name "#{Faker::Lorem.characters(8)}"
    active true
    factory :disabled_calendar do
      active false
    end
    factory :default_calendar do
      name 'litigo1test@gmail.com'
      calendar_id '4pgc6gtka9v1gqbatccqub56w'
      nylas_namespace_id 'angjx1hjrostsm309j3ti44m1'
    end
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
    factory :admin_user do
      role :admin
    end
    factory :invited_user do
      role :attorney
      firm_id 1
      invited_by_id 1
    end
  end

  factory :case do
    case_number "#{Random.rand(5)}"
    case_type "case type #{Faker::Lorem.characters(7)}"
    subtype "subtype #{Faker::Lorem.characters(7)}"
    name "#{Faker::Lorem.characters(8)}"
    description "#{Faker::Lorem.words(Random.rand(10)).join(" ")}"
    factory :medical_case do
      case_type 'Personal Injury'
      subtype 'Insurance Bad Faith'
      after(:create) do |incident_case|
        FactoryGirl.create(:incident, case: incident_case)
        FactoryGirl.create(:medical, case: incident_case)
        FactoryGirl.create(:insurance, case: incident_case)
      end
    end
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

  factory :medical do
    total_med_bills Random.rand(100)
    subrogated_amount Random.rand(100)
  end

  factory :insurance do

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
    note "#{Faker::Lorem.characters(8)}"
    note_type 'General'
  end

  factory :plantiff do

  end

  factory :task do
    name "#{Faker::Lorem.characters(8)}"
    due_date 1.week.from_now
    description "#{Faker::Lorem.characters(50)}"
  end

  factory :witness do
    first_name "#{Faker::Lorem.characters(8)}"
    last_name "#{Faker::Lorem.characters(8)}"
  end

end
