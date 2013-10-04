# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    street_address1 "MyString"
    street_address2 "MyString"
    city "MyString"
    postal_code "MyString"
    addressable_id 1
    addressable_type "MyString"
  end
end
