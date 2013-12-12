# == Schema Information
#
# Table name: discounts
#
#  id                :integer          not null, primary key
#  percentage        :decimal(2, 5)
#  passenger_type_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :discounts do
    percentage 1
  end
end
