# original version autogenerated by Stepford: https://github.com/garysweaver/stepford

FactoryGirl.define do
  
  factory :city do
    #after(:create) do |user, evaluator|; FactoryGirl.create_list :venue, 2; end # commented to avoid circular reference
    user
    name Faker::Address.city
    sequence(:id)
  end
  
end