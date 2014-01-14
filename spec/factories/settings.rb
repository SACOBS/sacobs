# == Schema Information
#
# Table name: settings
#
#  id                    :integer          not null, primary key
#  booking_expiry_period :integer
#  created_at            :datetime
#  updated_at            :datetime
#  ticket_instructions   :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :setting do
    booking_expiry_period 1
  end
end
