# == Schema Information
#
# Table name: line_items
#
#  id                  :integer          not null, primary key
#  description         :string(255)
#  discount_percentage :integer
#  discount_amount     :decimal(8, 2)
#  invoice_id          :integer
#  created_at          :datetime
#  updated_at          :datetime
#  gross_price         :decimal(8, 2)
#  nett_price          :decimal(8, 2)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :line_item do
    description "MyString"
    amount "9.99"
    discount_percentage 1
    discount_amount "9.99"
  end
end
