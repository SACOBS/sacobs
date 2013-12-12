# == Schema Information
#
# Table name: vouchers
#
#  id         :integer          not null, primary key
#  ref_no     :string(255)
#  amount     :decimal(, )
#  active     :boolean          default(TRUE)
#  client_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vouchers do
    ref_no "MyString"
    amount "9.99"
    active false
  end
end
