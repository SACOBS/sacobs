# == Schema Information
#
# Table name: invoices
#
#  id           :integer          not null, primary key
#  booking_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#  billing_date :datetime
#
# Indexes
#
#  index_invoices_on_booking_id  (booking_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invoice do
  end
end
