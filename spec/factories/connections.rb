# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :connection do
    from_city factory: :city
    to_city factory: :city
    route
    distance 1
  end
end
