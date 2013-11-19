# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vouchers do
    ref_no "MyString"
    amount "9.99"
    active false
  end
end
