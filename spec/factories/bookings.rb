# == Schema Information
#
# Table name: bookings
#
#  id           :integer          not null, primary key
#  trip_id      :integer
#  price        :decimal(, )
#  status       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  quantity     :integer          default(0)
#  expiry_date  :datetime
#  client_id    :integer
#  user_id      :integer
#  reference_no :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    trip_id 1
    price "9.99"
    status "MyString"
  end
end
