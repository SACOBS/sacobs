# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :seat do
    row "MyString"
    number 1
    bus nil
  end
end
