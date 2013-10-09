# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip do
    name "MyString"
    route_id 1
    bus_id 1
  end
end
