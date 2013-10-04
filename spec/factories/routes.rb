# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :routes do
    start_city factory: :city
    end_city factory: :city
    cost "9.99"
    distance 1
  end
end
