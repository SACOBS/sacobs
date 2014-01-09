# == Schema Information
#
# Table name: destinations
#
#  id                :integer          not null, primary key
#  route_id          :integer
#  city_id           :integer
#  sequence :integer
#  created_at        :datetime
#  updated_at        :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :destination do
    route_id 1
    city_id 1
    order 1
  end
end
