# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :line_item do
    description "MyString"
    amount "9.99"
    discount_percentage 1
    discount_amount "9.99"
  end
end
