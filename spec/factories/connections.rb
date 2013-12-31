# == Schema Information
#
# Table name: connections
#
#  id                  :integer          not null, primary key
#  distance            :integer
#  created_at          :datetime
#  updated_at          :datetime
#  route_id            :integer
#  percentage          :decimal(2, 5)
#  cost                :decimal(8, 2)
#  name                :string(255)
#  from_destination_id :integer
#  to_destination_id   :integer
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
