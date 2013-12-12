# == Schema Information
#
# Table name: seats
#
#  id         :integer          not null, primary key
#  row        :string(255)
#  number     :integer
#  bus_id     :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_seats_on_bus_id  (bus_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :seat do
    row "MyString"
    number 1
    bus nil
  end
end
