# original version autogenerated by Stepford: https://github.com/garysweaver/stepford

FactoryGirl.define do
  
  factory :route do
    #after(:create) do |user, evaluator|; FactoryGirl.create_list :connection, 2; end # commented to avoid circular reference
    #after(:create) do |user, evaluator|; FactoryGirl.create_list :destination, 2; end # commented to avoid circular reference
    user
    name 'TestRoute'
    cost 200
    distance 300
    sequence(:id)
  end
  
end