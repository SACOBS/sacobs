# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    trip_id 1
    price "9.99"
    status "MyString"
  end
end
