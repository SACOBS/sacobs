# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :charge do
    percentage "9.99"
    passenger_type_id 1
  end
end
