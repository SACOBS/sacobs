# == Schema Information
#
# Table name: charges
#
#  id          :integer          not null, primary key
#  percentage  :decimal(5, 2)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  description :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :charge do
    percentage "9.99"
    passenger_type_id 1
  end
end
