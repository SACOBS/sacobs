# == Schema Information
#
# Table name: connections
#
#  id           :integer          not null, primary key
#  from_city_id :integer
#  to_city_id   :integer
#  distance     :integer
#  created_at   :datetime
#  updated_at   :datetime
#  route_id     :integer
#  percentage   :integer
#  cost         :decimal(8, 2)
#  name         :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :connection do
    from_city factory: :city
    to_city factory: :city
    route
    distance 1
  end
end
