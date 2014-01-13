# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  street_address1  :string(255)
#  street_address2  :string(255)
#  city             :string(255)
#  postal_code      :string(255)
#  addressable_id   :integer
#  addressable_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_addresses_on_addressable_id_and_addressable_type  (addressable_id,addressable_type)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    street_address1 "MyString"
    street_address2 "MyString"
    city "MyString"
    postal_code "MyString"
    addressable_id 1
    addressable_type "MyString"
  end
end
