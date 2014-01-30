# == Schema Information
#
# Table name: line_items
#
#  id             :integer          not null, primary key
#  description    :string(255)
#  invoice_id     :integer
#  created_at     :datetime
#  updated_at     :datetime
#  amount         :decimal(8, 2)
#  line_item_type :string(255)
#
# Indexes
#
#  index_line_items_on_invoice_id  (invoice_id)
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
